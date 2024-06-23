import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

public class Main {

    public static void main(String[] args) {
        /* LEITURA DE N1, N2, N3 E N4*/
        Scanner scanner = new Scanner(System.in);
        int n1 = scanner.nextInt();
        int n2 = scanner.nextInt();
        int n3 = scanner.nextInt();
        int n4 = scanner.nextInt();
        scanner.close();

        /* LEITURA DE DADOS.CSV */
        String path = "dados.csv";
        List<Country> countriesList = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            countriesList = br.lines()
                    .map(line -> {
                        String[] values = line.split(",");
                        return new Country(values[0], Integer.valueOf(values[1]), Integer.valueOf(values[2]),
                                Integer.valueOf(values[3]), Integer.valueOf(values[4]));
                    })
                    .collect(Collectors.toList());
        } catch (IOException e) {
            e.printStackTrace();
        }

        /* EXERCÍCIO 1 */
        // DESCRIÇÃO: soma de "Active" de todos os países em que "Confirmed" é maior ou igual a n1
        int ansEx01 = countriesList.stream()
                .filter(country -> country.getConfirmed() >= n1)
                .mapToInt(Country::getActive)
                .sum();
        System.out.println(ansEx01);

        /* EXERCÍCIO 2 */
        // DESCRIÇÃO: Dentre os n2 países com maiores valores de "Active", a soma das "Deaths" dos n3 países
        // com menores valores de "Confirmed"."
        int ansEx02 = countriesList.stream()
                .sorted(Comparator.comparingInt(Country::getActive).reversed())
                .limit(n2)
                .sorted(Comparator.comparingInt(Country::getConfirmed))
                .limit(n3)
                .mapToInt(Country::getDeaths)
                .sum();
        System.out.println(ansEx02);

        /* EXERCÍCIO 3 */
        // DESCRIÇÃO: Os n4 países com os maiores valores de "Confirmed". Os nomes devem estar em ordem alfabética.
        countriesList.stream()
                .sorted(Comparator.comparingInt(Country::getConfirmed).reversed())
                .limit(n4)
                .sorted(Comparator.comparing(Country::toString))
                .forEach(System.out::println);
    }


    static class Country {
        private String country;
        private Integer confirmed;
        private Integer deaths;
        private Integer recovery;
        private Integer active;

        public Country(String country, Integer confirmed, Integer deaths, Integer recovery, Integer active) {
            this.country = country;
            this.confirmed = confirmed;
            this.deaths = deaths;
            this.recovery = recovery;
            this.active = active;
        }

        public String getCountry() {
            return country;
        }

        public Integer getConfirmed() {
            return confirmed;
        }

        public Integer getDeaths() {
            return deaths;
        }

        public Integer getRecovery() {
            return recovery;
        }

        public Integer getActive() {
            return active;
        }

        @Override
        public String toString() {
            return country;
        }
    }
}
