import { ComponentMeta, ComponentStory } from "@storybook/react";
import Nav, { Destination } from "navigation/Nav";
import HeaderBreadcrumbsComponent from ".";

export default {
  title: "Components/Header/Breadcrumbs",
  args: {
    currentDestination: Nav().secure.Index,
  },
  component: HeaderBreadcrumbsComponent,
} as ComponentMeta<typeof HeaderBreadcrumbsComponent>;

export const HeaderBreadcrumbs: ComponentStory<
  typeof HeaderBreadcrumbsComponent
> = ({ currentDestination, ...props }: { currentDestination: Destination }) => {
  return (
    <HeaderBreadcrumbsComponent
      {...props}
      currentDestination={currentDestination}
    />
  );
};
