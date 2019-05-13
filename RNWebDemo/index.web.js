import { AppRegistry,View,Text } from 'react-native';
import BasicTabBarExample from './src/MainTabbarPage'
// import HomeStack from './src/App'
import {name as appName} from './app.json';
AppRegistry.registerComponent(appName, () => BasicTabBarExample);
AppRegistry.runApplication(appName, { rootTag: document.getElementById('root') });