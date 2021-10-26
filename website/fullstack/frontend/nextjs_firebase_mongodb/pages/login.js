import React, { useState } from "react";
import firebaseClient from "../src/app/firebase.client";
import firebase from "firebase/compat/app";
import "firebase/compat/auth";
import admin from "firebase-admin";
import {
  Box,
  Flex,
  Input,
  FormControl,
  FormLabel,
  FormHelperText,
  Stack,
  Button,
  Heading,
  useToast,
} from "@chakra-ui/react";
import { async } from "@firebase/util";

export default function Login() {
  firebaseClient();
  const toast = useToast();
  const [email, setEmail] = useState("");
  const [pass, setPass] = useState("");

  return (
    <Flex>
      <Box w={500} p={4} my={12} mx="auto">
        <Heading as="h2" textAlign="center">
          Login
        </Heading>
        <FormControl isRequired>
          <FormLabel htmlFor="email">Email address</FormLabel>
          <Input
            onChange={(e) => setEmail(e.target.value)}
            type="email"
            id="email"
            value={email}
          ></Input>
        </FormControl>
        <FormControl isRequired>
          <FormLabel htmlFor="password">Password</FormLabel>
          <Input
            onChange={(e) => setPass(e.target.value)}
            type="password"
            id="pass"
            value={pass}
          ></Input>
        </FormControl>
        <Stack justify="center" mt={6} isInline spacing={10}>
          <Button
            minWidth="40%"
            variant="solid"
            isDisabled={email === "" || pass === ""}
            onClick={async () => {
              const expiresIn = 60 * 60 * 24 * 5 * 1000;
              await firebase
                .auth()

                .createUserWithEmailAndPassword(email, pass)
                .then(async function (user) {
                  // user.user.refreshToken
                  const token = await user.user.getIdToken();
                  await admin.auth().createSessionCookie(token, {
                    expiresIn: expiresIn,
                    httpOnly: true,
                    secure: true,
                  });
                  window.location.href = "/";
                })
                .catch(function (error) {
                  const message = error.message;
                  toast({
                    title: "An error occured",
                    description: message,
                    status: "error",
                    duration: "9000",
                    isClosable: true,
                  });
                });
            }}
          >
            Create Account
          </Button>
          <Button
            minWidth="40%"
            variant="solid"
            isDisabled={email === "" || pass === ""}
            onClick={async () => {
              await firebase
                .auth()
                .signInWithEmailAndPassword(email, pass)
                .then(async (user) => {
                  const token = await user.user.getIdToken();
                  await admin.auth().createSessionCookie(token, {
                    maxAge: expiresIn,
                    httpOnly: true,
                    secure: true,
                  });
                  window.location.href = "/";
                })
                .catch(function (error) {
                  const message = error.message;
                  toast({
                    title: "An error occured",
                    description: message,
                    status: "error",
                    duration: "9000",
                    isClosable: true,
                  });
                });
            }}
          >
            Login
          </Button>
        </Stack>
      </Box>
    </Flex>
  );
}
