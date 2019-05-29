import React from 'react';
import { Image, ScrollView, View,Text,TouchableOpacity } from 'react-native';
import { List } from '@ant-design/react-native';
import { createStackNavigator, createAppContainer } from 'react-navigation';
// import HomeScreen from "./MainTabbarPage";

const Item = List.Item;
const Brief = Item.Brief;

export class App extends React.Component<any, any> {
    static navigationOptions = {
        title: 'App',
    };

  render() {
    return (
        <ScrollView
            style={{ flex: 1, backgroundColor: '#f5f5f9' }}
            automaticallyAdjustContentInsets={false}
            showsHorizontalScrollIndicator={false}
            showsVerticalScrollIndicator={false}
        >
          <List renderHeader={'basic'}>
            <Item data-seed="logId"  >
              标题文字点击无反馈，文字超长则隐藏，文字超长则隐藏
            </Item>
            <Item wrap>
              文字超长折行文字超长折行文字超长折行文字超长折行文字超长折行
            </Item>
          </List>
            <TouchableOpacity
                onPress={()=>{
                    this.props.navigation.navigate('DetailScreen')
                }}
            >
                <Text>
                    点击跳转
                </Text>
            </TouchableOpacity>
        </ScrollView>
    );
  }
}

class DetailScreen extends React.Component{
  static navigationOptions = {
      title: 'DetailScreen',
  };

  render() {
    return (
        <View style={{flex: 1,justifyContent:'center',alignItems:'center'}} >
          <Text>DetailScreen</Text>
        </View>
    );
  }
}

class OptionsScreen extends React.Component{
    static navigationOptions = {
        title: 'DetailScreen',
    };

  render() {
    return (
        <View style={{flex: 1,justifyContent:'center',alignItems:'center'}} >
          <Text>OptionsScreen</Text>
        </View>
    );
  }
}

const HomeStack = createAppContainer(createStackNavigator(
    {
      DetailScreen:{
        screen:DetailScreen
      },
      OptionsScreen:{
        screen:OptionsScreen
      },App:{
          screen:App
      }
    },
    {
      initialRouteName: 'App',
      // transitionConfig: dynamicModalTransition
    }
));

export default HomeStack;
// export default App;