import { ErrorCode, ErrorDTO } from "@/api/dto/error";
import env from "@/env";
import { headers } from "next/headers";
import { NextResponse } from "next/server";

export function POST() {
  const authHeader = headers().get("authorization");
  if (authHeader === `Bearer ${env.AUTH_KEY}`) {
    return new Response(undefined, { status: 204 });
  } else {
    return NextResponse.json<ErrorDTO>(
      {
        code: ErrorCode.unauthorized,
        message: "You must be authenticated to access this resource.",
      },
      {
        status: 401,
      }
    );
  }
}
