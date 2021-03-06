package dk.holstandersen.rpncal.operators;

import android.content.Context;
import dk.holstandersen.rpncal.R;
import dk.holstandersen.rpncal.RPNOperationException;

public class Log10Operator extends AbstractContextualUnaryOperator {

	public Log10Operator(Context c) {
		super(c);
	}

	@Override
	public Double calculate(Double arg)
			throws RPNOperationException {
		if (arg<=0) {
			throw new RPNOperationException(getString(R.string.msg_log_of_non_positive));
		}
		return Math.log10(arg);
	}

}
