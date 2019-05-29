import React from 'react';
import { Image, ScrollView, View } from 'react-native';
import { List } from '@ant-design/react-native';
import { createSwitchNavigator } from '@react-navigation/core'
import { createBrowserApp } from '@react-navigation/web'
import TouchableOpacity from "react-native-web/src/exports/TouchableOpacity";
import {Text} from "antd-mobile";

const Item = List.Item;
const Brief = Item.Brief;

export class BasicListExample extends React.Component<any, any> {
    render() {
        return (
            <ScrollView
                style={{ flex: 1, backgroundColor: '#f5f5f9' }}
                automaticallyAdjustContentInsets={false}
                showsHorizontalScrollIndicator={false}
                showsVerticalScrollIndicator={false}
            >
                <List renderHeader={'basic'}>
                    <Item data-seed="logId">
                        标题文字点击无反馈，文字超长则隐藏，文字超长则隐藏
                    </Item>            
                    <Item wrap>
                        文字超长折行文字超长折行文字超长折行文字超长折行文字超长折行
                    </Item>
                </List>               
                <TouchableOpacity
                    onPress={()=>{
                        this.props.navigation.navigate('MainTabNavigator')
                    }}
                >
                    <Text>点击跳转</Text>
                </TouchableOpacity>
            </ScrollView>
        );
    }
}

export class Example extends React.Component<any, any> {
    render() {
        return (
            <ScrollView
                style={{ flex: 1, backgroundColor: '#f5f5f9' }}
                automaticallyAdjustContentInsets={false}
                showsHorizontalScrollIndicator={false}
                showsVerticalScrollIndicator={false}
            >
                <List renderHeader={'basic'}>
                    <Item data-seed="logId">
                        标题文字点击无反馈，文字超长则隐藏，文字超长则隐藏
                    </Item>
                </List>
            </ScrollView>
        );
    }
}

export const MainNavigator = createSwitchNavigator(
    {
        Launch: { screen: BasicListExample },
        MainTabNavigator: { screen: Example },

    },
    {
        initialRouteName: 'Launch',
    }
)
const AppContainer = createBrowserApp(MainNavigator);

export default AppContainer;