"use client";

import { ReactNode, createContext, useState } from "react";
import { Upload } from "react-feather";

export const FileDropContext = createContext<FileList | null>(null);

export default function FileDropContextProvider({
  children,
}: {
  children: ReactNode;
}) {
  const [isDraggingFile, setDraggingFile] = useState(false);
  const [droppedFiles, setDroppedFiles] = useState<FileList | null>(null);
  return (
    <FileDropContext.Provider value={droppedFiles}>
      <div
        className="min-h-full h-full"
        onDragEnter={() => setDraggingFile(true)}
        onDragLeave={(e) => {
          if (e.target === e.currentTarget) {
            setDraggingFile(false);
          }
        }}
        onDragEnd={() => setDraggingFile(false)}
        onDragOver={(e) => e.preventDefault()}
        onDrop={(e) => {
          e.preventDefault();

          setDraggingFile(false);
          setDroppedFiles(e.dataTransfer.files);
        }}
      >
        {isDraggingFile && (
          <div className="flex flex-col items-center justify-center fixed inset-0 bg-base-200/90 z-50">
            <Upload className="w-16 h-16" />
            <span className="text-4xl mt-4">Lägg till bild(er)</span>
          </div>
        )}
        {children}
      </div>
    </FileDropContext.Provider>
  );
}
