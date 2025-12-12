package service;

import java.util.Arrays;
import java.util.List;

public class HistoryService {
    public List<String> getHistory(long userId) {
        // Demo data
        return Arrays.asList("Played X", "Played Y", "Played Z");
    }
}