package dk.holstandersen.rpncal.operators;

import dk.holstandersen.rpncal.RPNOperationException;

public class ATanOperator implements UnaryOperator {

	@Override
	public Double calculate(Double arg)
			throws RPNOperationException {
		return Math.atan(arg);
	}

}
