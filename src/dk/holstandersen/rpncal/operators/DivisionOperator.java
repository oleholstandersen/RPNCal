package dk.holstandersen.rpncal.operators;

import android.content.Context;
import dk.holstandersen.rpncal.R;
import dk.holstandersen.rpncal.RPNOperationException;

public class DivisionOperator extends AbstractContextualBinaryOperator {

	public DivisionOperator(Context c) {
		super(c);
	}

	@Override
	public Double calculate(Double arg1, Double arg2) throws RPNOperationException {
		if (arg2==0.0) throw new RPNOperationException(getString(R.string.msg_div_by_zero));
		return arg1/arg2;
	}

}
