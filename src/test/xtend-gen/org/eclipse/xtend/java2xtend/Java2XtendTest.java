package org.eclipse.xtend.java2xtend;

import java.io.InputStream;
import org.apache.commons.io.IOUtils;
import org.eclipse.xtend.java2xtend.Java2Xtend;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.InputOutput;
import org.junit.Assert;
import org.junit.Test;

@SuppressWarnings("all")
public class Java2XtendTest {
  @Test
  public void convert() {
    this.convertResource("/Board.java.txt");
  }
  
  public String convertResource(final String name) {
    try {
      String _xblockexpression = null;
      {
        Class<? extends Java2XtendTest> _class = this.getClass();
        InputStream _resourceAsStream = _class.getResourceAsStream(name);
        final String java = IOUtils.toString(_resourceAsStream);
        Java2Xtend _java2Xtend = new Java2Xtend();
        final Java2Xtend j2x = _java2Xtend;
        final String xtend = j2x.toXtend(java);
        Assert.assertNotNull(xtend);
        String _println = InputOutput.<String>println(xtend);
        _xblockexpression = (_println);
      }
      return _xblockexpression;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
