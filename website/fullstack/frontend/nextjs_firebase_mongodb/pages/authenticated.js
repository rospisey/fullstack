import React from "react";
import nookie from "nookies";
import { verifyIdToken } from "../src/app/firebase.admin";
import firebaseClient from "../src/app/firebase.client";
import firebase from "firebase/compat/app";
import { Box, Flex, Text, Heading, Button } from "@chakra-ui/react";
const admin = require("firebase-admin");

function Authenticated({ session }) {
  firebaseClient();
  if (session) {
    return (
      <Flex>
        <Box w={500} p={4} my={12} mx="auto">
          <Heading as="h2" mb={12} textAlign="center">
            Authenticated
          </Heading>
          <Text textAlign="center">{session}</Text>
          <Text textAlign="center">
            You do anything now you are authenticated
          </Text>
        </Box>
        <Box w={500} p={4} my={12} mx="auto"></Box>
        <Button
          width="100%"
          variant="solid"
          onClick={async () => {
            await firebase.auth().signOut();
            window.location.href = "/";
          }}
        >
          Sign out
        </Button>
      </Flex>
    );
  } else {
    return (
      <Box>
        <Text> Loading</Text>
      </Box>
    );
  }
}

export async function getServerSideProps(context) {
  try {
    const cookies = nookie.get(context);
    // const createToken = await admin.auth().createCustomToken(cookies.token);
    const token = await verifyIdToken(cookies.token);

    // await admin.auth().verifySessionCookie()
    // const token = await verifyIdToken(createToken);
    // console.log(`${createToken}`);

    // console.log(`${JSON.stringify(context)}`);
    const { uid, email } = token;
    return {
      props: { session: `Your email is ${email} and your UID is ${uid}` },
    };
  } catch (err) {
    // if (refreshToken && e.code === FIREBASE_ERROR_TOKEN_EXPIRED) {
    //   const newToken = refreshExpiredIdToken();
    //   console.log(`${newToken}`);
    //   context.res.end();
    //   return { props: {} };
    // }
    console.log(err);
    context.res.writeHead(302, { location: "/login" });
    context.res.end();
    return { props: {} };
  }
}

// const getTokenPrefix = () =>
//   process.env.FIREBASE_AUTH_EMULATOR_HOST
//     ? `http://${process.env.FIREBASE_AUTH_EMULATOR_HOST}/`
//     : "https://";

// const getFirebasePublicAPIKey = () => {
//   const config = getConfig();
//   return config.firebaseClientInitConfig.apiKey;
// };

// const refreshExpiredIdToken = async (refreshToken) => {
//   if (!refreshToken) {
//     throw new Error('The "refreshToken" argument is required.');
//   }

//   // https://firebase.google.com/docs/reference/rest/auth/#section-refresh-token
//   // const firebasePublicAPIKey = getFirebasePublicAPIKey();
//   const firebasePublicAPIKey = "AIzaSyDgQsnSbfFDBc_uUDPcE7QQtuesDi1UBgM";

//   const endpoint = `${getTokenPrefix()}securetoken.googleapis.com/v1/token?key=${firebasePublicAPIKey}`;

//   const response = await fetch(endpoint, {
//     method: "POST",
//     headers: {
//       "Content-Type": "application/x-www-form-urlencoded",
//     },
//     body: `grant_type=refresh_token&refresh_token=${refreshToken}`,
//   });
//   const responseJSON = await response.json();
//   if (!response.ok) {
//     throw new Error(
//       `Problem refreshing token: ${JSON.stringify(responseJSON)}`
//     );
//   }
//   const idToken = responseJSON.id_token;
//   return idToken;
// };
export default Authenticated;
