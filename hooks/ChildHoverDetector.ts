import { RefObject, useEffect, useState } from "react";

const focusableSelector = `button:not([disabled]), [href], input:not([disabled]), select:not([disabled]), textarea:not([disabled]), [tabindex]:not([tabindex="-1"]):not([disabled]), details:not([disabled]), summary:not(:disabled)`;

export default function useChildHoverDetector(
  ref: RefObject<HTMLElement>
): boolean {
  const [childHovered, setChildHovered] = useState(false);
  useEffect(() => {
    if (ref.current === null) return;
    const self = ref.current;

    function detectChildHover() {
      setChildHovered(
        Array.from(self.querySelectorAll(":hover")).some((it) =>
          it.matches(focusableSelector)
        )
      );
    }

    self.addEventListener("mouseover", detectChildHover);
    self.addEventListener("mouseout", detectChildHover);

    return () => {
      self.removeEventListener("mouseover", detectChildHover);
      self.removeEventListener("mouseout", detectChildHover);
    };
  }, [ref, setChildHovered]);

  return childHovered;
}
