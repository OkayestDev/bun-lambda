import { createServer, get, defaultErrorHandler } from "valita-server";
import type { Request, Response } from "valita-server";

get("/transpiled", (_: Request): Response => {
  return {
    status: 200,
    body: { message: "Hello from transpiled handler" },
  };
});

get("/transpiled/error", (_: Request): Response => {
  throw new Error("Error");
});

const server = createServer({
  enableRequestLogging: true,
  enableResponseLogging: true,
  errorHandler: (error: Error) => {
    console.error({ error });
    return defaultErrorHandler(error);
  },
});

// Docker Lambda adapter expects server to listen on port 8080
server.listen(8080, () => {
  console.log("Server is running on port 8080");
});
