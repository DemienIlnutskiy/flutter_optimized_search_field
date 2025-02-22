# Flutter Optimized Search Field

A Flutter package that provides optimized search fields with various customization options. This package offers four distinct widgets designed to cover different search needs:

1. **OptimizedSearchField**  
   A search field specifically designed for text-based searches. It is highly optimized for large lists, offering excellent performance with minimal configuration. While not highly customizable, it’s perfect for quick implementations.

2. **BasicSearchField**  
   A more customizable version of OptimizedSearchField. It retains all its performance benefits and extends functionality by supporting model-based data. Each search result can include descriptions, images, or other elements, though it requires more parameters for setup.

3. **MultiSearchField**  
   A specialized search field designed for array-based searches. Unlike traditional text search fields that update in real time, MultiSearchField only triggers a search after the user presses enter—adding the item to the selected items.

4. **BasicMultiSearchField**  
   A highly customizable version of MultiSearchField. It includes all the benefits of MultiSearchField and supports complex data types (models), where each search result can contain rich content like descriptions or images. This version requires additional parameters, trading ease of use for flexibility.

## Preview

Below are some previews demonstrating the key features of the package:

### [Search Field](https://github.com/DemienIlnutskiy/flutter_optimized_search_field/blob/main/lib/optimized_search_field_widget.dart)

<img src="https://raw.githubusercontent.com//DemienIlnutskiy/flutter_optimized_search_field/main/assets/read_me/adavptive_menu_position.gif">

### [Multi Search](https://github.com/DemienIlnutskiy/flutter_optimized_search_field/blob/main/lib/multi_search_field.dart)

<img src="https://raw.githubusercontent.com//DemienIlnutskiy/flutter_optimized_search_field/main/assets/read_me/multi_search_field_preview.gif">

### [Adaptive Menu Position](https://github.com/DemienIlnutskiy/flutter_optimized_search_field/blob/main/lib/based_search_field.dart)

<img src="https://raw.githubusercontent.com//DemienIlnutskiy/flutter_optimized_search_field/main/assets/read_me/adavptive_menu_position.gif">

  * This gif shows that if there isn’t enough space above the widget, the menu will adapt and display from the bottom—even if the top position is selected. First has position up and second has down*

## Features

- **Optimized for Performance:**  
  Designed to handle large data sets efficiently, making it ideal for applications with extensive lists.

- **Customizability:**  
  Choose between simple, easy-to-integrate fields and highly customizable widgets that support complex data types and rich content.

- **Adaptive UI:**  
  The options menu intelligently adapts to available screen space, ensuring an optimal user experience regardless of device orientation or screen size.

## Detailed Widget Descriptions

### OptimizedSearchField

**Description:**  
A search field created for text searches. It is highly optimized for large lists and provides an easy start with minimal configuration, though customization is limited.

**Pros:**  
- Excellent performance with large data sets  
- Easy to integrate

**Cons:**  
- Limited customization options

**Example Usage:**

```dart
OptimizedSearchField(
  onChanged: (text) => setState(() {
    currentItem = text;
  }),
  labelText: 'Enter Item',
  dropDownList: List.generate(
    100000,
    (index) => 'item ${index + 1}',
  ),
  itemStyle: const ButtonStyle(
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
    padding: WidgetStatePropertyAll(
      EdgeInsets.symmetric(vertical: 16),
    ),
  ),
  menuMaxHeight: 200,
  optionsViewOpenDirection: OptionsViewOpenDirection.up,
)
```

---
### BasicSearchField

**Description:**  
A much more customizable version of OptimizedSearchField. While it requires more parameters for setup, it supports both text and model-based searches—allowing each search result to include descriptions, images, or other elements.

**Pros:**  
- Extensive customization options  
- Supports complex data types

**Cons:**  
- More complex setup compared to OptimizedSearchField

**Example Usage:**

```dart
BasicSearchField<MyModel>(
  labelText: 'Search',
  optionsBuilder: (TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return myModelList;
    }
    return myModelList.where((model) {
      return model.name.toLowerCase().contains(textEditingValue.text.toLowerCase());
    });
  },
  items: (model) => ListTile(
    title: Text(model.name),
    subtitle: Text(model.description),
    leading: Image.network(model.imageUrl),
  ),
  onSelected: (model) {
    print('Selected: ${model.name}');
  },
)
```

---
### MultiSearchField

**Description:**  
A search field tailored for array-based searches. It does not trigger actions on every keystroke. Instead, it waits until the user presses enter to trigger a method that adds the typed element to the selected items.

**Pros:**  
- Ideal for building multi-selection inputs  
- Prevents premature search triggering

**Cons:**  
- Not suitable for real-time search feedback

**Example Usage:**

```dart
MultiSearchField(
  labelText: 'Enter Items',
  dropDownList: List.generate(
    100000,
    (index) => 'item ${index + 1}',
  ),
  removeEvent: (value) => setState(() {
    currentItems.remove(value);
  }),
  values: currentItems,
  onChanged: (text) => setState(() {
    currentItems.add(text);
  }),
  menuMaxHeight: 400,
)
```

---
### BasicMultiSearchField

**Description:**  
A highly customizable version of MultiSearchField that supports model-based searches. Each search result can include rich content such as descriptions and images, offering greater flexibility at the cost of a more complex configuration.

**Pros:**  
- High customizability for multi-selection scenarios  
- Supports detailed and complex data representations

**Cons:**  
- Increased configuration complexity

**Example Usage:**

```dart
BasicMultiSearchField<MyModel>(
  labelText: 'Search Items',
  dropDownList: myModelList,
  values: selectedModels,
  removeEvent: (model) => setState(() {
    selectedModels.remove(model);
  }),
  onChanged: (text) {
    final model = MyModel(name: text, description: '', imageUrl: '');
    setState(() {
      selectedModels.add(model);
    });
  },
  optionsBuilder: (TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return myModelList;
    }
    return myModelList.where((model) {
      return model.name.toLowerCase().contains(textEditingValue.text.toLowerCase());
    });
  },
  item: (model) => ListTile(
    title: Text(model.name),
    subtitle: Text(model.description),
    leading: Image.network(model.imageUrl),
  ),
  selectedWidget: (model) => Chip(
    label: Text(model.name),
    onDeleted: () => setState(() {
      selectedModels.remove(model);
    }),
  ),
)
```

## Public API Documentation

### BasicMultiSearchField

**Properties:**

- `allElements`: All elements text.
- `controller`: Controller for the search field.
- `customTextField`: Custom text field widget.
- `description`: Description for the search field.
- `dropDownList`: List of dropdown items.
- `errorText`: Error text for the search field.
- `fieldActiveIcon`: Active icon for the search field.
- `fieldDecoration`: Decoration for the search field.
- `fieldInactiveIcon`: Inactive icon for the search field.
- `fieldInputFormatters`: Input formatters for the search field.
- `fieldSuffixIcon`: Suffix icon for the search field.
- `focusNode`: Focus node for the search field.
- `getItemText`: Function to get the text for an item.
- `isRequired`: Whether the search field is required.
- `item`: Widget for each item in the dropdown.
- `itemStyle`: Style for the items.
- `labelText`: Label text for the search field.
- `labelTextStyle`: Style for the label text.
- `listClipBehavior`: Clip behavior for the list.
- `listItem`: Custom list item widget.
- `menuDecoration`: Decoration for the menu.
- `menuMargin`: Margin for the menu.
- `menuMaxHeight`: Maximum height for the menu.
- `onChanged`: Callback for text change.
- `onFieldSubmitted`: Callback for field submission.
- `onSelected`: Callback for item selection.
- `optionsBuilder`: Function to build the options for the dropdown.
- `optionsViewOpenDirection`: Direction for the options view.
- `removeEvent`: Callback for removing an item.
- `selectedItemClipBehavior`: Clip behavior for the selected item.
- `selectedItemIcon`: Icon for the selected item.
- `selectedItemMaxLines`: Maximum number of lines for the selected item.
- `selectedItemSpacing`: Spacing for the selected item.
- `selectedItemStyle`: Style for the selected item.
- `selectedItemTextAlign`: Text alignment for the selected item.
- `selectedItemTextOverflow`: Text overflow for the selected item.
- `selectedItemTextStyle`: Text style for the selected item.
- `selectedWidget`: Widget for the selected item.
- `showErrorText`: Whether to show the error text.
- `suffixIconPadding`: Padding for the suffix icon.
- `textFieldKey`: Key for the text field.
- `trailingList`: List of trailing widgets.
- `unfocusSuffixIcon`: Suffix icon for the search field when unfocused.
- `values`: List of selected values.

**Methods:**

- `build`: Builds the widget tree.
- `dispose`: Disposes of the controller and focus node.
- `initState`: Initializes the controller and focus node.
- `unFocusData`: Unfocuses the data when the focus node loses focus.
- `handleKeyEvent`: Handles key events for the focus node.

For more detailed documentation, please refer to the source code and comments within the package.
