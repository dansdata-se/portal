import { ComponentMeta, ComponentStory } from "@storybook/react";
import Button from "components/Button";
import { useRef, useState } from "react";
import { AlertOctagon, Search } from "react-feather";
import TextFieldComponent from ".";

export default {
  title: "Components/TextField",
  component: TextFieldComponent,
  args: {
    variant: "filled",
    type: "text",
    label: "Label",
    placeholder: "",
    supportingText: "Supporting text",
    disabled: false,
  },
  argTypes: {
    maxLength: {
      type: "number",
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
  },
} as ComponentMeta<typeof TextFieldComponent>;

export const TextField: ComponentStory<typeof TextFieldComponent> = (args) => {
  const ref = useRef<HTMLInputElement>(null);
  const [isValid, setValid] = useState(true);
  return (
    <>
      <TextFieldComponent
        ref={ref}
        {...args}
      />
      <br />
      <br />
      <Button
        variant="filled"
        onClick={() => setValid(ref.current?.reportValidity() ?? true)}
        text="Check validity"
      />
      <br />
      <span>Last check: {isValid ? "valid" : "invalid"}</span>
    </>
  );
};
TextField.args = {
  required: false,
};

export const TextFieldWithIcons = (args: any) => {
  return (
    <TextFieldComponent
      {...args}
      leading={args.withLeading ? args.leading : null}
      trailing={args.withTrailing ? args.trailing : null}
    />
  );
};
TextFieldWithIcons.args = {
  withLeading: true,
  withTrailing: false,
  leading: <Search />,
  trailing: <AlertOctagon key="alert" />,
};

export const TextFieldWithText = (args: any) => {
  return (
    <TextFieldComponent
      {...args}
      leading={args.withLeading ? args.leading : null}
      trailing={args.withTrailing ? args.trailing : null}
    />
  );
};
TextFieldWithText.args = {
  withLeading: true,
  leading: "$",
  withTrailing: false,
  trailing: "lbs",
};
TextFieldWithText.argTypes = {
  leading: {
    type: "string",
    table: {
      disable: false,
    },
  },
  trailing: {
    type: "string",
    table: {
      disable: false,
    },
  },
};

export const TextFieldWithIconButtons = (args: any) => {
  return (
    <TextFieldComponent
      {...args}
      leading={args.withLeading ? args.leading : null}
      trailing={args.withTrailing ? args.trailing : null}
    />
  );
};
TextFieldWithIconButtons.args = {
  withLeading: true,
  withTrailing: false,
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
