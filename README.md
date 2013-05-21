java2xtend
==========

The aim it to aid in converting pure Java code to Xtend sources.
Uses Eclipse JDT AST for Java parsing.
Licenced under [Eclipse Public License](http://www.eclipse.org/legal/epl-v10.html)

You can try it online at http://www.j2x.cloudbees.net/

The converter also tries to Xtend'ify Java constructs like:

| Java                                       | Xtend                              | 
| -------------------------------------------|------------------------------------|
| obj1.equals(obj2)                          | obj1 == obj2                       |
| obj1 == obj2                               | obj1 === obj2                      |
| System.out.println(...)                    | println(...)                       |
| private final String v="abc";              | val v="abc"                        |
| person.setName(other.getPerson().getName); | person.name = other.person.name    |

Example:

	package com.example;
	
	import java.io.Serializable;
	import java.util.ArrayList;
	import java.util.List;
	
	public class Test implements Serializable {
		private static final long serialVersionUID = 1L;
		private List<String> list = null;
		private List<String> otherList = new ArrayList<String>();
	
		public Test(List<String> list) {
			this.list = list;
		}
		public static void main(String[] args) {
			System.out.println("Hello World!");
		}
	}
after convertion will become

	package com.example
	
	import java.io.Serializable
	import java.util.ArrayList
	import java.util.List
	
	class Test implements Serializable {
		static val serialVersionUID = 1L
		List<String> list = null
		var otherList = new ArrayList<String>()
	
		new(List<String> list) {
			this.list = list;
		}
		def static void main(String[] args) {
			println("Hello World!")
		}
	}
Usage
=====

	val j2x = new org.eclipse.xtend.java2xtend.Java2Xtend;
	val javaCode = '//java code'
	val String xtendCode = j2x.toXtend(javaCode);
Build
=====
1. Generate Eclipse project: `mvn eclipse:eclipse`
2. In Eclipse import the project using `File > Import > Existing project into workspace...`
3. Make sure you have the Xtend Eclipse Plugin. You can install it from Eclipse marketplace (`Help > Eclipse Marketplace ...`)
