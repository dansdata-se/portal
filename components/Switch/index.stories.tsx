import { ComponentMeta, ComponentStory } from "@storybook/react";
import SwitchComponent, { SimpleSwitchState } from ".";

export default {
  title: "Components/Switch",
  component: SwitchComponent,
  args: {
    state: SimpleSwitchState.INDETERMINATE,
    disabled: false,
  },
  argTypes: {
    state: {
      options: Object.keys(SimpleSwitchState),
      mapping: SimpleSwitchState,
    },
    altText: {
      table: {
        disable: true,
      },
    },
  },
} as ComponentMeta<typeof SwitchComponent>;

export const Switch: ComponentStory<typeof SwitchComponent> = ({
  state,
  ...props
}) => {
  return (
    <SwitchComponent
      {...props}
      state={state}
    />
  );
};
