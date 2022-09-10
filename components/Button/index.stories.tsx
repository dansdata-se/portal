import { ComponentMeta, ComponentStory } from "@storybook/react";
import { Plus } from "react-feather";
import ButtonComponent from ".";

export default {
  title: "Components/Button",
  component: ButtonComponent,
  args: {
    variant: "elevated",
    text: "Click me!",
    disabled: false,
  },
  argTypes: {
    icon: {
      type: "boolean",
      defaultValue: false,
    },
  },
} as ComponentMeta<typeof ButtonComponent>;

export const Button: ComponentStory<typeof ButtonComponent> = ({
  icon,
  ...props
}) => {
  return (
    <ButtonComponent
      {...props}
      icon={icon ? <Plus /> : undefined}
    />
  );
};
