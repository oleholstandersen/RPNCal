package dk.holstandersen.rpncal.operators;

import android.content.Context;
import android.content.ContextWrapper;

public abstract class AbstractContextualUnaryOperator extends ContextWrapper implements UnaryOperator {

	public AbstractContextualUnaryOperator(Context base) {
		super(base);
	}

}
