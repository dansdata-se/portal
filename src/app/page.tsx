"use client";

import api from "@/api";
import { MetadataDTO } from "@/api/dto/metadata";
import IndividualForm from "@/app/individual_form";
import LoginBox from "@/app/login_box";
import OrganizationForm from "@/app/organization_form";
import VenueForm from "@/app/venue_form";
import { CloudflareResultDTOSchema } from "@/cloudflare/dto/result";
import logger from "@/logger";
import classNames from "classnames";
import Image from "next/image";
import { useState } from "react";
import { MapPin, User, Users } from "react-feather";
import { useIsClient, useLocalStorage } from "usehooks-ts";
import wretch from "wretch";
import FormDataAddon from "wretch/addons/formData";

function isFulfilledPromise<T>(
  result: PromiseSettledResult<T>
): result is PromiseFulfilledResult<T> {
  return result.status === "fulfilled";
}

function isRejectedPromise(
  result: PromiseSettledResult<unknown>
): result is PromiseRejectedResult {
  return result.status === "rejected";
}

export default function Page() {
  const [authToken, setAuthToken] = useLocalStorage("authToken", "");
  const isLoggedIn = !!authToken;
  const [activeTab, setActiveTab] = useState<
    "organization" | "individual" | "venue" | null
  >(null);
  const [isSubmitting, setSubmitting] = useState(false);
  const isClient = useIsClient();

  async function submitPhotos(photosWithMetadata: [File, MetadataDTO][]) {
    setSubmitting(true);
    try {
      const results = await Promise.allSettled(
        photosWithMetadata.map(async ([file, metadata]) => {
          const { uploadURL } = await api.images.post(authToken, metadata);
          const result = await wretch(uploadURL)
            .addon(FormDataAddon)
            .errorType("json")
            .formData({
              file,
            })
            .resolve(
              async (r) =>
                await CloudflareResultDTOSchema.parseAsync(await r.json())
            )
            .post();

          if (!result.success) {
            throw result.errors;
          }
        })
      );
      const fulfilled = results.filter(isFulfilledPromise);
      const rejected = results.filter(isRejectedPromise);

      logger.debug(
        {
          fulfilled: fulfilled.length,
          rejected: rejected.length,
        },
        "Submission complete"
      );

      if (rejected.length > 0) {
        // eslint-disable-next-line @typescript-eslint/no-unsafe-return
        throw rejected.map((it) => it.reason);
      }

      alert("Tack för ditt bidrag!");
      window.location.reload();
    } catch (e) {
      logger.error(e, "Submission error");
      alert(
        "Något gick tyvärr fel. Kontakta dansdata@googlegroups.com om felet kvarstår!"
      );
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <main className="flex flex-col min-h-full">
      <header className="py-12 border-b-2">
        <div className="flex flex-row gap-6 items-center justify-center">
          <Image
            className="rounded-md"
            src="/icon.png"
            alt="Dansdata Logo"
            width={75}
            height={75}
            priority
          />
          <div className="prose">
            <h1 className="text-5xl m-0">Dansdata</h1>
            <p className="italic m-0">Vi vet när Sverige dansar!</p>
          </div>
        </div>
      </header>
      {isClient && !isLoggedIn && <LoginBox onLogin={setAuthToken} />}
      {isClient && isLoggedIn && (
        <>
          <section className="carousel-item pt-16 pb-8">
            <div className="container">
              <div className="prose">
                <h2>Vad vill du lägga till?</h2>
              </div>
              <div className="tabs tabs-boxed xl:grid xl:grid-cols-3 justify-around my-8">
                <a
                  onClick={() => setActiveTab("organization")}
                  className={classNames("tab grow transition-all", {
                    "tab-active": activeTab === "organization",
                  })}
                >
                  <Users className="mr-2" />
                  Band/Förening/Företag
                </a>
                <a
                  onClick={() => setActiveTab("individual")}
                  className={classNames("tab grow transition-all", {
                    "tab-active": activeTab === "individual",
                  })}
                >
                  <User className="mr-2" />
                  Person
                </a>
                <a
                  onClick={() => setActiveTab("venue")}
                  className={classNames("tab grow transition-all", {
                    "tab-active": activeTab === "venue",
                  })}
                >
                  <MapPin className="mr-2" />
                  Plats
                </a>
              </div>
            </div>
          </section>
          <section>
            {activeTab === "organization" && (
              <OrganizationForm
                isSubmitting={isSubmitting}
                onSubmit={(e) => void submitPhotos(e)}
              />
            )}
            {activeTab === "individual" && (
              <IndividualForm
                isSubmitting={isSubmitting}
                onSubmit={(e) => void submitPhotos(e)}
              />
            )}
            {activeTab === "venue" && (
              <VenueForm
                isSubmitting={isSubmitting}
                onSubmit={(e) => void submitPhotos(e)}
              />
            )}
          </section>
        </>
      )}
    </main>
  );
}
