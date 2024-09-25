package algo;

//baekjoon 9333
public class Savings {
	public static void main(String[] args) {
		System.out.println(Savings.execute(6165009, 500000, 0.05, true));
	}
	
	public static int execute(int targetAmount, int depositAmount, double interestRate, boolean isCompound) {
		double targetMonth = 0;
		
		if(isCompound) {
			targetMonth = (-1 + Math.sqrt(1+4*interestRate/24*targetAmount/depositAmount))/interestRate*12;
		}else {
			targetMonth = calculateMonths(targetAmount, depositAmount, interestRate);
		}
		
		return (int) Math.ceil(targetMonth);
	}
	
	static double calculateFutureValue(double months, double monthlyDeposit, double interestRate) {
        double monthlyRate = interestRate / 12; // 월 이자율
        double futureValue = 0;

        for (int i = 0; i < months; i++) {
            futureValue = (futureValue + monthlyDeposit) * (1 + monthlyRate);
        }

        return futureValue;
    }

    static double calculateMonths(int targetAmount, int depositAmount, double interestRate) {
        double low = 0;
        double high = 1000; // 충분히 큰 수
        double epsilon = 0.01; // 오차 범위

        while (high - low > epsilon) {
            double mid = (low + high) / 2;
            double calculatedAmount = calculateFutureValue(mid, depositAmount, interestRate);

            if (calculatedAmount < targetAmount) {
                low = mid; // 목표 금액보다 작으면 범위를 증가
            } else {
                high = mid; // 목표 금액보다 크면 범위를 감소
            }
        }

        return (low + high) / 2; // 최종 결과 반환
    }
}
