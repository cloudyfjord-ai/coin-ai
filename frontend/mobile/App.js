import React, { useState } from "react";
import { View, Text, TextInput, Button, Alert } from "react-native";

export default function App() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  const login = async () => {
    const response = await fetch("http://10.0.2.2:5000/login", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ username, password }),
    });
    const data = await response.json();
    Alert.alert(data.message);
  };

  return (
    <View style={{ padding: 20 }}>
      <Text>Coin Recognition Mobile App</Text>
      <TextInput
        placeholder="Username"
        value={username}
        onChangeText={(text) => setUsername(text)}
      />
      <TextInput
        placeholder="Password"
        secureTextEntry
        value={password}
        onChangeText={(text) => setPassword(text)}
      />
      <Button title="Login" onPress={login} />
    </View>
  );
}
