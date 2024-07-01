import { al } from './al.js'

export default {
    configureHljs: (hljs) => {
        // Customize hightlight.js here
        hljs.registerLanguage('al', al);
    },
}