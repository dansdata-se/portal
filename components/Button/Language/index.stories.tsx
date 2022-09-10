import { ComponentMeta, ComponentStory } from "@storybook/react";
import LanguageButtonComponent from ".";

export default {
  title: "Components/Button/Language",
  component: LanguageButtonComponent,
  args: {
    variant: "text",
  },
} as ComponentMeta<typeof LanguageButtonComponent>;

export const LanguageButton: ComponentStory<typeof LanguageButtonComponent> = ({
  ...props
}) => <LanguageButtonComponent {...props} />;
