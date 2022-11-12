import { ComponentMeta, ComponentStory } from "@storybook/react";
import CircularProgressButtonComponent from ".";

export default {
  title: "Components/Button/Progress/Circular",
  component: CircularProgressButtonComponent,
  args: {
    variant: "elevated",
    text: "Button",
    disabled: false,
    loading: true,
  },
} as ComponentMeta<typeof CircularProgressButtonComponent>;

export const CircularProgressButton: ComponentStory<
  typeof CircularProgressButtonComponent
> = (props) => {
  return <CircularProgressButtonComponent {...props} />;
};
