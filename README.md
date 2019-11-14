# Equipment Sets

Manage equipment sets in World of Warcraft Classic via slash commands. No GUI.

## Slash Commands

- **/equipset**

  Equip a saved set.

  Example:
  ```
  /equipset pvp
  ```

- **/showset**
  
  Show all items in a set.
  
  Example:
  ```
  /showset tank
  ```

- **/saveset**

  Save all currently equipped items to a set.
  
  Example:
  ```
  /saveset dps
  ```

- **/deleteset**

  Delete a set.
  
  Example:
  ```
  /deleteset spirit
  ```
  
- **/listsets**

  List all saved sets.
  
  Example:
  ```
  /listsets
  ```

## API Functions

- **UseEquipmentSet**

  Example:

  ```
  UseEquipmentSet("pvp")
  ```
