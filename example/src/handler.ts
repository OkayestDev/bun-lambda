import { createServer, get } from "valita-server";
import type { Request, Response } from "valita-server";

get("/", (_: Request): Response => {
  return {
    status: 200,
    body: { message: "Hello World" },
  };
});

const server = createServer({
  enableRequestLogging: true,
  enableResponseLogging: true,
});

server.listen(8080, () => {
  console.log("Server is running on port 8080");
});

export default server;
