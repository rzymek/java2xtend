import java.util.Arrays;
import java.util.Collections;


public class StaticAccess {
	private void foo() {
		Arrays.asList(1,2,3); //MethodInvocation
		java.util.Arrays.asList(1,2,3); //MethodInvocation
		this.foo(); //MethodInvocation
		java.util.Collections.emptyList(); //MethodInvocation
		Object o = Collections.EMPTY_LIST; //QualifiedName
	}
}
