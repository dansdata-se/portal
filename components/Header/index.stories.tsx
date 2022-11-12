import { ComponentMeta, ComponentStory } from "@storybook/react";
import Nav, { Destination } from "navigation/Nav";
import HeaderComponent from ".";

export default {
  title: "Components/Header",
  args: {
    currentDestination: Nav().secure.Home,
  },
  component: HeaderComponent,
} as ComponentMeta<typeof HeaderComponent>;

export const Header: ComponentStory<typeof HeaderComponent> = ({
  currentDestination,
  ...props
}: {
  currentDestination: Destination;
}) => {
  return (
    <HeaderComponent
      {...props}
      currentDestination={currentDestination}
    />
  );
};
