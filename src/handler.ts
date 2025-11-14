import { createLambda, get } from "valita-server";
import type { Request, Response } from "valita-server";

get("/", (_: Request): Response => {
  return {
    status: 200,
    body: { message: "Hello World" },
  };
});

export const handler = createLambda({
  enableRequestLogging: true,
  enableResponseLogging: true,
});
