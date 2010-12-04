package dk.holstandersen.rpncal.operators;

import android.content.Context;
import android.content.ContextWrapper;

public abstract class AbstractContextualBinaryOperator extends ContextWrapper implements BinaryOperator {
	
	public AbstractContextualBinaryOperator(Context c) {
		super(c);
	}
}
