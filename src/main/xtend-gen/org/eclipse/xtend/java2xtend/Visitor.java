package org.eclipse.xtend.java2xtend;

import com.google.common.base.Objects;
import java.util.List;
import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.ASTVisitor;
import org.eclipse.jdt.core.dom.Block;
import org.eclipse.jdt.core.dom.Expression;
import org.eclipse.jdt.core.dom.MethodDeclaration;
import org.eclipse.jdt.core.dom.MethodInvocation;
import org.eclipse.jdt.core.dom.Modifier;
import org.eclipse.jdt.core.dom.SimpleName;
import org.eclipse.jdt.core.dom.SingleVariableDeclaration;
import org.eclipse.jdt.core.dom.Type;
import org.eclipse.jdt.core.dom.TypeDeclaration;
import org.eclipse.xtend2.lib.StringConcatenation;
import org.eclipse.xtext.xbase.lib.Functions.Function0;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.InputOutput;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;

@SuppressWarnings("all")
public class Visitor extends ASTVisitor {
  private final StringBuilder xtend = new Function0<StringBuilder>() {
    public StringBuilder apply() {
      StringBuilder _stringBuilder = new StringBuilder();
      return _stringBuilder;
    }
  }.apply();
  
  public boolean visit(final TypeDeclaration node) {
    boolean _xblockexpression = false;
    {
      StringConcatenation _builder = new StringConcatenation();
      _builder.append("class ");
      SimpleName _name = node.getName();
      _builder.append(_name, "");
      _builder.append(" {");
      _builder.newLineIfNotEmpty();
      this.xtend.append(_builder);
      _xblockexpression = (true);
    }
    return _xblockexpression;
  }
  
  public void preVisit(final ASTNode node) {
    Class<? extends ASTNode> _class = node.getClass();
    InputOutput.<Class<? extends ASTNode>>println(_class);
  }
  
  public boolean visit(final Block block) {
    boolean _xblockexpression = false;
    {
      this.xtend.append("{\n");
      _xblockexpression = (true);
    }
    return _xblockexpression;
  }
  
  public boolean visit(final MethodInvocation statement) {
    boolean _xblockexpression = false;
    {
      Expression _expression = statement.getExpression();
      String _string = _expression==null?(String)null:_expression.toString();
      boolean _equals = Objects.equal(_string, "System.out");
      if (_equals) {
        StringConcatenation _builder = new StringConcatenation();
        SimpleName _name = statement.getName();
        _builder.append(_name, "");
        _builder.append("(");
        List _arguments = statement.arguments();
        String _join = IterableExtensions.join(_arguments, ", ");
        _builder.append(_join, "");
        _builder.append(")");
        _builder.newLineIfNotEmpty();
        this.xtend.append(_builder);
      } else {
        this.xtend.append(statement);
      }
      _xblockexpression = (true);
    }
    return _xblockexpression;
  }
  
  public boolean visit(final MethodDeclaration node) {
    boolean _xblockexpression = false;
    {
      final Iterable<Modifier> modifiers = this.getModifiers(node);
      List _parameters = node.parameters();
      final Function1<Object,SingleVariableDeclaration> _function = new Function1<Object,SingleVariableDeclaration>() {
          public SingleVariableDeclaration apply(final Object it) {
            return ((SingleVariableDeclaration) it);
          }
        };
      final List<SingleVariableDeclaration> params = ListExtensions.<Object, SingleVariableDeclaration>map(_parameters, _function);
      boolean _isConstructor = node.isConstructor();
      if (_isConstructor) {
        StringConcatenation _builder = new StringConcatenation();
        _builder.append("\t");
        _builder.append("def new(");
        {
          boolean _hasElements = false;
          for(final SingleVariableDeclaration param : params) {
            if (!_hasElements) {
              _hasElements = true;
            } else {
              _builder.appendImmediate(", ", "	");
            }
            Type _type = param.getType();
            _builder.append(_type, "	");
            _builder.append(" ");
            SimpleName _name = param.getName();
            _builder.append(_name, "	");
          }
        }
        _builder.append(")");
        this.xtend.append(_builder);
      } else {
        StringConcatenation _builder_1 = new StringConcatenation();
        _builder_1.append("\t");
        _builder_1.append("def ");
        String _join = IterableExtensions.join(modifiers, " ");
        _builder_1.append(_join, "	");
        _builder_1.append(" ");
        Type _returnType2 = node.getReturnType2();
        _builder_1.append(_returnType2, "	");
        _builder_1.append(" ");
        SimpleName _name_1 = node.getName();
        _builder_1.append(_name_1, "	");
        _builder_1.append("(");
        {
          boolean _hasElements_1 = false;
          for(final SingleVariableDeclaration param_1 : params) {
            if (!_hasElements_1) {
              _hasElements_1 = true;
            } else {
              _builder_1.appendImmediate(", ", "	");
            }
            Type _type_1 = param_1.getType();
            _builder_1.append(_type_1, "	");
            _builder_1.append(" ");
            SimpleName _name_2 = param_1.getName();
            _builder_1.append(_name_2, "	");
          }
        }
        _builder_1.append(")");
        this.xtend.append(_builder_1);
      }
      _xblockexpression = (true);
    }
    return _xblockexpression;
  }
  
  public boolean isAbstract(final Iterable<Modifier> modifiers) {
    final Function1<Modifier,Boolean> _function = new Function1<Modifier,Boolean>() {
        public Boolean apply(final Modifier it) {
          boolean _isAbstract = it.isAbstract();
          return Boolean.valueOf(_isAbstract);
        }
      };
    Iterable<Modifier> _filter = IterableExtensions.<Modifier>filter(modifiers, _function);
    boolean _isEmpty = IterableExtensions.isEmpty(_filter);
    boolean _not = (!_isEmpty);
    return _not;
  }
  
  public Iterable<Modifier> getModifiers(final MethodDeclaration node) {
    List _modifiers = node.modifiers();
    final Function1<Object,Modifier> _function = new Function1<Object,Modifier>() {
        public Modifier apply(final Object it) {
          return ((Modifier) it);
        }
      };
    List<Modifier> _map = ListExtensions.<Object, Modifier>map(_modifiers, _function);
    final Function1<Modifier,Boolean> _function_1 = new Function1<Modifier,Boolean>() {
        public Boolean apply(final Modifier it) {
          boolean _isPublic = it.isPublic();
          boolean _not = (!_isPublic);
          return Boolean.valueOf(_not);
        }
      };
    Iterable<Modifier> _filter = IterableExtensions.<Modifier>filter(_map, _function_1);
    return _filter;
  }
  
  public void endVisit(final Block node) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("}");
    _builder.newLine();
    this.xtend.append(_builder);
  }
  
  public void endVisit(final TypeDeclaration node) {
    StringConcatenation _builder = new StringConcatenation();
    _builder.append("}");
    this.xtend.append(_builder);
  }
  
  public String toString() {
    String _string = this.xtend.toString();
    return _string;
  }
  
  public static void main(final String[] args) {
  }
}
