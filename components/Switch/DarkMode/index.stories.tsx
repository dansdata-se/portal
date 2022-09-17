import { ComponentMeta, ComponentStory } from "@storybook/react";
import DarkModeSwitchComponent from ".";

export default {
  title: "Components/Switch/Dark Mode",
  component: DarkModeSwitchComponent,
} as ComponentMeta<typeof DarkModeSwitchComponent>;

export const DarkModeSwitch: ComponentStory<
  typeof DarkModeSwitchComponent
> = () => <DarkModeSwitchComponent />;
