import { MetadataDTO } from "@/api/dto/metadata";
import { CreateImageUploadUrlDTO } from "@/api/dto/image";
import wretch from "wretch";

const base = (authToken?: string) => {
  let w = wretch("/api/").errorType("json");

  if (authToken) {
    w = w
      .options({ credentials: "include", mode: "cors" })
      .auth(authToken ? `Bearer ${authToken}` : "");
  }

  return w;
};

const api = {
  auth: {
    ping(authToken: string) {
      return base(authToken).post(undefined, "auth/ping/").res();
    },
  },

  images: {
    post(authToken: string, metadata: MetadataDTO) {
      return base(authToken)
        .post(metadata, "images/")
        .json<CreateImageUploadUrlDTO>();
    },
  },
};

export default api;
