package dk.holstandersen.rpncal.operators;

import android.content.Context;
import dk.holstandersen.rpncal.R;
import dk.holstandersen.rpncal.RPNOperationException;

public class SqrtOperator extends AbstractContextualUnaryOperator {

	public SqrtOperator(Context c) {
		super(c);
	}

	@Override
	public Double calculate(Double arg)
			throws RPNOperationException {
		if (arg<0) {
			throw new RPNOperationException(getString(R.string.msg_root_of_negative));
		}
		return Math.sqrt(arg);
	}

}
