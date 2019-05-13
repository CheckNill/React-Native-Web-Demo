import { AppRegistry,View,Text } from 'react-native';
// import MyTest from './src/MyTest';
// import {MMTest} from './src'
import MMTest from './MMTest';
AppRegistry.registerComponent('RNTesterApp', () => MMTest);
AppRegistry.runApplication('RNTesterApp', { rootTag: document.getElementById('root') });