
# JavaScript
## REPL (Read Eval Print Loop)
* [codepen](https://codepen.io/)
* [babel](https://babeljs.io/repl/)

## Variable declaration:  var, let & const
Declaration | Limitation | Re-declaration | Re-assignment | Note
--- | --- | :---: | --- | --- 
const | Strictest | N | N | must be assigned at declaration time
let | Moderate | N | Y |
var | Weakest | Y | Y |

## Operators
* == equal
* != not equal
* === strict equal
* !== not strict equal
* ternary
	```javascript
	14 - 7 === 7 ? 'Yep!' : 'Nope.'; // Yep!
	```


## Functions
To represent a function `f(x) = x* 2`, and assign it with the name "double":
```javascript
const double = x => x * 2;
```
The value of the a function expression is the function itself:
```javascript
double; // [Function: double]
```
To check the function definition, use `.toString()` method:
```javascript
double.toString(); // 'x => x * 2'
```



## Objects
An object in JavaScript is a collection of key: value pairs. It also has a literal notation:
```javascript
{  
  key: 'value'  
}
```

And of course, you can assign an object to a name:
```javascript
const foo = {  
  bar: 'bar'  
}
```