import { ComponentMeta, ComponentStory } from "@storybook/react";
import Button from "components/Button";
import { Plus } from "react-feather";
import CardComponent, { CardAttributes } from ".";

export default {
  title: "Components/Card",
  component: CardComponent,
} as ComponentMeta<typeof CardComponent>;

export const Card: ComponentStory<typeof CardComponent> = (
  args: CardAttributes
) => (
  <CardComponent {...args}>
    <img
      className="w-full"
      src="https://placekitten.com/600/200"
    />
    <div className="prose card-content">
      <h5 className="mt-0">Headline</h5>
      <h6 className="mt-0">Subhead</h6>
      <p>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ut
        purus eget elit tincidunt vehicula nec vitae sem.
      </p>
      <hr />
      <p>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ut
        purus eget elit tincidunt vehicula nec vitae sem.
      </p>
    </div>
    <hr className="my-4" />
    <div className="flex gap-card-buttons card-content">
      <Button
        variant="outlined"
        text="Click me"
      />
      <Button
        variant="filled"
        text="Click me"
        icon={<Plus />}
        className="flex-grow"
      />
    </div>
  </CardComponent>
);
Card.args = {
  variant: "elevated",
  disabled: false,
  dragging: false,
};
Card.argTypes = {
  tabIndex: {
    type: "number",
    description: "Makes the card focusable and clickable",
    defaultValue: null,
  },
  onClick: {
    action: "clicked",
  },
};
