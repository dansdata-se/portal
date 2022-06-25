import { ComponentMeta, ComponentStory } from "@storybook/react";
import { Plus } from "react-feather";
import ButtonComponent, { ButtonAttributes } from ".";

type TemplateButtonAttributes = { icon: boolean } & Omit<
  ButtonAttributes,
  "icon"
>;

function TemplateButton(args: TemplateButtonAttributes) {
  const buttonAttrs: ButtonAttributes = {
    ...args,
    icon: args.icon ? <Plus /> : undefined,
  };
  return <ButtonComponent {...buttonAttrs} />;
}

export default {
  title: "Components/Button",
  component: ButtonComponent,
  argTypes: {
    icon: {
      type: "boolean",
    },
  },
} as ComponentMeta<typeof ButtonComponent>;

const Template: ComponentStory<typeof TemplateButton> = (
  args: TemplateButtonAttributes
) => <TemplateButton {...args} />;

export const Button = Template.bind({});
Button.args = {
  variant: "elevated",
  text: "Click me!",
  disabled: false,
  icon: true,
};
