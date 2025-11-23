import { createServer, get, defaultErrorHandler, log } from "valita-server";
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

function loggingFn(path: string, data: Record<string, any>) {
  log.info(path, {
    ...data,
    headers: undefined,
  });
}

const server = createServer({
  enableRequestLogging: true,
  enableResponseLogging: true,
  loggingFn,
  errorHandler: (error: Error) => {
    return defaultErrorHandler(error);
  },
});

// Docker Lambda adapter expects server to listen on port 8080
server.listen(8080, () => {
  console.log("Server is running on port 8080");
});
