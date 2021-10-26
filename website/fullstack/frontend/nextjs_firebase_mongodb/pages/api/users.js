import nextConnect from "next-connect";
const app = nextConnect();
import initAuth from "../../utils/initAuth";
import middleware from "../../components/middleware";
initAuth();
const handler = app
  .use((req, res, next) => {
    middleware(req, res, next);
  })
  .get((req, res) => {
    return res.status(200).json({ value: "hello world" });
  });

export default handler;
