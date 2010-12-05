package dk.holstandersen.rpncal.operators;

import android.content.Context;
import dk.holstandersen.rpncal.R;
import dk.holstandersen.rpncal.RPNOperationException;

public class InvertOperator extends AbstractContextualUnaryOperator {

	public InvertOperator(Context base) {
		super(base);
	}

	@Override
	public Double calculate(Double arg) throws RPNOperationException {
		if (arg==0.0) throw new RPNOperationException(getString(R.string.msg_div_by_zero));
		return Math.pow(arg, -1);
	}

}
