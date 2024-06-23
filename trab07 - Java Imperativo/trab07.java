import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

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
            String row;
            while ((row = br.readLine()) != null) {
                String[] values = row.split(",");
                String country = values[0];
                Integer confirmed = Integer.valueOf(values[1]);
                Integer deaths = Integer.valueOf(values[2]);
                Integer recovery = Integer.valueOf(values[3]);
                Integer active = Integer.valueOf(values[4]);
                countriesList.add(new Country(country, confirmed, deaths, recovery, active));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        /* TRANSFORMANDO LIST EM ARRAY PARA EVIDENCIAR PARADIGMA IMPERATIVO */
        int tam = countriesList.size();
        Country[] countries = new Country[tam];
        int k = 0;
        for (Country country : countriesList) {
            countries[k] = country;
            k++;
        }

        /* EXERCÍCIO 1 */
        // DESCRIÇÃO: soma de "Active" de todos os países em que "Confirmed" é maior ou igual a n1

        Integer ansEx01 = 0;
        for (Country country : countries) {
            if (country.getConfirmed() >= n1) {
                ansEx01 += country.getActive();
            }
        }
        System.out.println(ansEx01);

        /* EXERCÍCIO 2 */
        // DESCRIÇÃO: Dentre os n2 países com maiores valores de "Active", a soma das "Deaths" dos n3 países
        // com menores valores de "Confirmed"."
        Integer ansEx02 = 0;

        // Ordena de forma decrescente usando atributo "active"
        for (int i = 0; i < tam; i++) {
            for (int j = i + 1; j < tam; j++) {
                if (countries[i].getActive() < countries[j].getActive()) {
                    Country temp = countries[i];
                    countries[i] = countries[j];
                    countries[j] = temp;
                }
            }
        }

        // Ordena os n2 primeiros de forma crescente usando atributo "confirmed"
        for (int i = 0; i < n2; i++) {
            for (int j = i + 1; j < n2; j++) {
                if (countries[i].getConfirmed() > countries[j].getConfirmed()) {
                    Country temp = countries[i];
                    countries[i] = countries[j];
                    countries[j] = temp;
                }
            }
        }

        // Pega os n3 primeiros países e soma o atributo "deaths"
        for (int i = 0; i < n3; i++) {
            ansEx02 += countries[i].getDeaths();
        }

        // Imprime
        System.out.println(ansEx02);

        /* EXERCÍCIO 3 */
        // DESCRIÇÃO: Os n4 países com os maiores valores de "Confirmed". Os nomes devem estar em ordem alfabética.

        // Ordena de forma decrescente usando atributo "confirmed"
        for (int i = 0; i < tam; i++) {
            for (int j = i + 1; j < tam; j++) {
                if (countries[i].getConfirmed() < countries[j].getConfirmed()) {
                    Country temp = countries[i];
                    countries[i] = countries[j];
                    countries[j] = temp;
                }
            }
        }

        // Ordena os n4 primeiros de forma crescente usando atributo "country"
        for (int i = 0; i < n4; i++) {
            for (int j = i + 1; j < n4; j++) {
                int compare = countries[i].getCountry().compareTo(countries[j].getCountry());
                if (compare > 0) {
                    Country temp = countries[i];
                    countries[i] = countries[j];
                    countries[j] = temp;
                }
            }
        }

        // Impressão
        for (int i = 0; i < n4; i++) {
            System.out.println(countries[i]);
        }
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
