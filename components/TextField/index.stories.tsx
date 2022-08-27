import { ComponentMeta, ComponentStory } from "@storybook/react";
import { useState } from "react";
import { AlertOctagon, Search } from "react-feather";
import TextFieldComponent, { TextFieldAttributes } from ".";

export default {
  title: "Components/TextField",
  component: TextFieldComponent,
  args: {
    variant: "filled",
    type: "multilineText",
    label: "Label",
    placeholder: "",
    supportingText: "Supporting text",
    error: false,
    disabled: false,
    required: false,
    withLeading: true,
    withTrailing: false,
  },
  argTypes: {
    withLeading: {
      type: "boolean",
    },
    withTrailing: {
      type: "boolean",
    },
    leading: {
      table: {
        disable: true,
      },
    },
    trailing: {
      table: {
        disable: true,
      },
    },
    value: {
      table: {
        disable: true,
      },
    },
    onValueChange: {
      table: {
        disable: true,
      },
    },
    pattern: {
      table: {
        disable: true,
      },
    },
    required: {
      table: {
        disable: true,
      },
    },
  },
} as ComponentMeta<typeof TextFieldComponent>;

export const TextField: ComponentStory<typeof TextFieldComponent> = (
  args: TextFieldAttributes
) => {
  const [value, setValue] = useState("");
  return (
    <TextFieldComponent
      {...args}
      value={value}
      onValueChange={setValue}
    />
  );
};

export const TextFieldWithIcons = (
  args: TextFieldAttributes & { withLeading: boolean; withTrailing: boolean }
) => {
  const [value, setValue] = useState("");
  return (
    <TextFieldComponent
      {...args}
      leading={args.withLeading ? args.leading : null}
      trailing={args.withTrailing ? args.trailing : null}
      value={value}
      onValueChange={setValue}
    />
  );
};
TextFieldWithIcons.args = {
  leading: <Search />,
  trailing: <AlertOctagon key="alert" />,
};

export const TextFieldWithText = (
  args: TextFieldAttributes & { withLeading: boolean; withTrailing: boolean }
) => {
  const [value, setValue] = useState("");
  return (
    <TextFieldComponent
      {...args}
      leading={args.withLeading ? args.leading : null}
      trailing={args.withTrailing ? args.trailing : null}
      value={value}
      onValueChange={setValue}
    />
  );
};
TextFieldWithText.args = {
  leading: "$",
  trailing: "lbs",
};

export const TextFieldWithIconButtons = (
  args: TextFieldAttributes & { withLeading: boolean; withTrailing: boolean }
) => {
  const [value, setValue] = useState("");
  return (
    <TextFieldComponent
      {...args}
      leading={args.withLeading ? args.leading : null}
      trailing={args.withTrailing ? args.trailing : null}
      value={value}
      onValueChange={setValue}
    />
  );
};
TextFieldWithIconButtons.args = {
  leading: (
    <button>
      <Search />
    </button>
  ),
  trailing: (
    <button>
      <AlertOctagon key="alert" />
    </button>
  ),
};
