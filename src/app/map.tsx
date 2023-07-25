"use client";

import L from "leaflet";
import "leaflet/dist/leaflet.css";
import { useEffect, useRef, useState } from "react";
import { renderToStaticMarkup } from "react-dom/server";
import { MapPin } from "react-feather";
import { MapContainer, Marker, TileLayer, useMapEvents } from "react-leaflet";

const initialPosition = { lat: 58.1519089, lng: 14.9472723 };
const clickTimeout = 500;

export interface LatLng {
  lat: number;
  lng: number;
}

function LocationMarker({
  onLocationSelected,
}: {
  onLocationSelected: (location: LatLng) => void;
}) {
  const [position, setPosition] = useState<LatLng | null>(null);
  const clickTimestamp = useRef(0);
  const clickCount = useRef(0);
  useMapEvents({
    click(e) {
      const now = new Date().getTime();
      if (now - clickTimestamp.current > clickTimeout) {
        clickCount.current = 0;
      }
      clickCount.current++;
      clickTimestamp.current = now;
      setTimeout(() => {
        if (clickCount.current > 1) return;
        setPosition({
          lat: e.latlng.lat,
          lng: e.latlng.lng,
        });
      }, clickTimeout);
    },
  });

  useEffect(() => {
    if (position) {
      onLocationSelected(position);
    }
  }, [onLocationSelected, position]);

  return position === null ? null : (
    <Marker
      position={position}
      icon={L.divIcon({
        html: renderToStaticMarkup(
          <MapPin className="fill-white stroke-primary" />
        ),
        iconSize: [24, 24],
        iconAnchor: [12, 24],
        className: "bg-transparent border-none",
      })}
    />
  );
}

export default function Map({
  onLocationSelected,
}: {
  onLocationSelected: (location: LatLng) => void;
}) {
  return (
    <MapContainer
      className="w-full h-full"
      center={initialPosition}
      zoom={6}
      scrollWheelZoom
    >
      <TileLayer
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
      />
      <LocationMarker onLocationSelected={onLocationSelected} />
    </MapContainer>
  );
}
