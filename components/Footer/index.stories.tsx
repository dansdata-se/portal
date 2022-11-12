import { ComponentMeta, ComponentStory } from "@storybook/react";
import FooterComponent from ".";

export default {
  title: "Components/Footer",
  component: FooterComponent,
} as ComponentMeta<typeof FooterComponent>;

export const Footer: ComponentStory<typeof FooterComponent> = ({
  ...props
}) => {
  return <FooterComponent {...props} />;
};
