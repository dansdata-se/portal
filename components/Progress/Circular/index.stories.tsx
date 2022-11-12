import { ComponentMeta, ComponentStory } from "@storybook/react";
import Button from "components/Button";
import CircularProgressIndicatorComponent, {
  CircularProgressIndicatorAttributes,
} from "./CircularProgressIndicator";

export default {
  title: "Components/Progress/Circular",
  component: CircularProgressIndicatorComponent,
  args: {
    color: "primary",
    sizing: "fixed",
  },
  argTypes: {
    color: {
      control: {
        type: "select",
      },
    },
    sizing: {
      control: {
        type: "select",
      },
    },
    progress: {
      type: "number",
    },
  },
} as ComponentMeta<typeof CircularProgressIndicatorComponent>;

export const CircularProgressIndicator: ComponentStory<
  typeof CircularProgressIndicatorComponent
> = (props: CircularProgressIndicatorAttributes) => (
  <CircularProgressIndicatorComponent {...props} />
);

export const IndicatorWithProgress: ComponentStory<
  typeof CircularProgressIndicatorComponent
> = ({ color, progress }) => (
  <CircularProgressIndicatorComponent
    color={color}
    progress={progress}
  />
);
IndicatorWithProgress.args = {
  progress: 0.5,
};

export const IndicatorWithoutProgress: ComponentStory<
  typeof CircularProgressIndicatorComponent
> = ({ color }) => <CircularProgressIndicatorComponent color={color} />;
IndicatorWithoutProgress.argTypes = {
  progress: {
    table: {
      disable: true,
    },
  },
};

export const ButtonWithIndicatorIcon: ComponentStory<any> = ({
  disabled,
  color,
  variant,
}) => (
  <Button
    variant={variant}
    text="Button"
    disabled={disabled}
    icon={
      <CircularProgressIndicatorComponent
        color={color}
        sizing="text"
      />
    }
  />
);
ButtonWithIndicatorIcon.args = {
  color: "currentColor",
  disabled: false,
  variant: "elevated",
};
ButtonWithIndicatorIcon.argTypes = {
  variant: {
    options: ["text", "elevated", "filled", "tonal"],
    control: {
      type: "select",
    },
  },
};
