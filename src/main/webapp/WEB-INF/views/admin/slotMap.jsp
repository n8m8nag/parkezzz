<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.typeshii.model.Slot" %>
<%@ page import="com.typeshii.model.Lot" %>
<%@ page import="com.typeshii.model.Record" %>
<%!
    // ---- Skill-Motorcycle: 105 slots (6 cols x 15 rows + 15 bottom) — canvas 980x920 ----
    static final double[][] POS_SKILL_MOTO = {
        {6.3265, 6.9565, 7.7551, 4.1304},
        {6.3265, 11.9565, 7.7551, 4.1304},
        {6.3265, 16.9565, 7.7551, 4.1304},
        {6.3265, 21.9565, 7.7551, 4.1304},
        {6.3265, 26.9565, 7.7551, 4.1304},
        {6.3265, 31.9565, 7.7551, 4.1304},
        {6.3265, 36.9565, 7.7551, 4.1304},
        {6.3265, 41.9565, 7.7551, 4.1304},
        {6.3265, 46.9565, 7.7551, 4.1304},
        {6.3265, 51.9565, 7.7551, 4.1304},
        {6.3265, 56.9565, 7.7551, 4.1304},
        {6.3265, 61.9565, 7.7551, 4.1304},
        {6.3265, 66.9565, 7.7551, 4.1304},
        {6.3265, 71.9565, 7.7551, 4.1304},
        {6.3265, 76.9565, 7.7551, 4.1304},
        {25.7143, 6.9565, 7.7551, 4.1304},
        {25.7143, 11.9565, 7.7551, 4.1304},
        {25.7143, 16.9565, 7.7551, 4.1304},
        {25.7143, 21.9565, 7.7551, 4.1304},
        {25.7143, 26.9565, 7.7551, 4.1304},
        {25.7143, 31.9565, 7.7551, 4.1304},
        {25.7143, 36.9565, 7.7551, 4.1304},
        {25.7143, 41.9565, 7.7551, 4.1304},
        {25.7143, 46.9565, 7.7551, 4.1304},
        {25.7143, 51.9565, 7.7551, 4.1304},
        {25.7143, 56.9565, 7.7551, 4.1304},
        {25.7143, 61.9565, 7.7551, 4.1304},
        {25.7143, 66.9565, 7.7551, 4.1304},
        {25.7143, 71.9565, 7.7551, 4.1304},
        {25.7143, 76.9565, 7.7551, 4.1304},
        {36.1224, 6.9565, 7.7551, 4.1304},
        {36.1224, 11.9565, 7.7551, 4.1304},
        {36.1224, 16.9565, 7.7551, 4.1304},
        {36.1224, 21.9565, 7.7551, 4.1304},
        {36.1224, 26.9565, 7.7551, 4.1304},
        {36.1224, 31.9565, 7.7551, 4.1304},
        {36.1224, 36.9565, 7.7551, 4.1304},
        {36.1224, 41.9565, 7.7551, 4.1304},
        {36.1224, 46.9565, 7.7551, 4.1304},
        {36.1224, 51.9565, 7.7551, 4.1304},
        {36.1224, 56.9565, 7.7551, 4.1304},
        {36.1224, 61.9565, 7.7551, 4.1304},
        {36.1224, 66.9565, 7.7551, 4.1304},
        {36.1224, 71.9565, 7.7551, 4.1304},
        {36.1224, 76.9565, 7.7551, 4.1304},
        {55.5102, 6.9565, 7.7551, 4.1304},
        {55.5102, 11.9565, 7.7551, 4.1304},
        {55.5102, 16.9565, 7.7551, 4.1304},
        {55.5102, 21.9565, 7.7551, 4.1304},
        {55.5102, 26.9565, 7.7551, 4.1304},
        {55.5102, 31.9565, 7.7551, 4.1304},
        {55.5102, 36.9565, 7.7551, 4.1304},
        {55.5102, 41.9565, 7.7551, 4.1304},
        {55.5102, 46.9565, 7.7551, 4.1304},
        {55.5102, 51.9565, 7.7551, 4.1304},
        {55.5102, 56.9565, 7.7551, 4.1304},
        {55.5102, 61.9565, 7.7551, 4.1304},
        {55.5102, 66.9565, 7.7551, 4.1304},
        {55.5102, 71.9565, 7.7551, 4.1304},
        {55.5102, 76.9565, 7.7551, 4.1304},
        {65.9184, 6.9565, 7.7551, 4.1304},
        {65.9184, 11.9565, 7.7551, 4.1304},
        {65.9184, 16.9565, 7.7551, 4.1304},
        {65.9184, 21.9565, 7.7551, 4.1304},
        {65.9184, 26.9565, 7.7551, 4.1304},
        {65.9184, 31.9565, 7.7551, 4.1304},
        {65.9184, 36.9565, 7.7551, 4.1304},
        {65.9184, 41.9565, 7.7551, 4.1304},
        {65.9184, 46.9565, 7.7551, 4.1304},
        {65.9184, 51.9565, 7.7551, 4.1304},
        {65.9184, 56.9565, 7.7551, 4.1304},
        {65.9184, 61.9565, 7.7551, 4.1304},
        {65.9184, 66.9565, 7.7551, 4.1304},
        {65.9184, 71.9565, 7.7551, 4.1304},
        {65.9184, 76.9565, 7.7551, 4.1304},
        {85.3061, 6.9565, 7.7551, 4.1304},
        {85.3061, 11.9565, 7.7551, 4.1304},
        {85.3061, 16.9565, 7.7551, 4.1304},
        {85.3061, 21.9565, 7.7551, 4.1304},
        {85.3061, 26.9565, 7.7551, 4.1304},
        {85.3061, 31.9565, 7.7551, 4.1304},
        {85.3061, 36.9565, 7.7551, 4.1304},
        {85.3061, 41.9565, 7.7551, 4.1304},
        {85.3061, 46.9565, 7.7551, 4.1304},
        {85.3061, 51.9565, 7.7551, 4.1304},
        {85.3061, 56.9565, 7.7551, 4.1304},
        {85.3061, 61.9565, 7.7551, 4.1304},
        {85.3061, 66.9565, 7.7551, 4.1304},
        {85.3061, 71.9565, 7.7551, 4.1304},
        {85.3061, 76.9565, 7.7551, 4.1304},
        {5.4082, 87.8261, 4.3878, 8.6957},
        {10.6122, 87.8261, 4.3878, 8.6957},
        {15.8163, 87.8261, 4.3878, 8.6957},
        {21.0204, 87.8261, 4.3878, 8.6957},
        {26.2245, 87.8261, 4.3878, 8.6957},
        {31.4286, 87.8261, 4.3878, 8.6957},
        {36.6327, 87.8261, 4.3878, 8.6957},
        {41.8367, 87.8261, 4.3878, 8.6957},
        {47.0408, 87.8261, 4.3878, 8.6957},
        {52.2449, 87.8261, 4.3878, 8.6957},
        {57.4490, 87.8261, 4.3878, 8.6957},
        {62.6531, 87.8261, 4.3878, 8.6957},
        {67.8571, 87.8261, 4.3878, 8.6957},
        {73.0612, 87.8261, 4.3878, 8.6957},
        {78.2653, 87.8261, 4.3878, 8.6957},
    };

    // ---- Skill-Car: 120 slots (4 main cols x22 + 3 right boxes) ----
    static final double[][] POS_SKILL_CAR = {
        {7.6372, 6.6071, 9.5465, 3.2143},
        {7.6372, 10.5357, 9.5465, 3.2143},
        {7.6372, 14.4643, 9.5465, 3.2143},
        {7.6372, 18.3929, 9.5465, 3.2143},
        {7.6372, 22.3214, 9.5465, 3.2143},
        {7.6372, 26.2500, 9.5465, 3.2143},
        {7.6372, 30.1786, 9.5465, 3.2143},
        {7.6372, 34.1071, 9.5465, 3.2143},
        {7.6372, 38.0357, 9.5465, 3.2143},
        {7.6372, 41.9643, 9.5465, 3.2143},
        {7.6372, 45.8929, 9.5465, 3.2143},
        {7.6372, 49.8214, 9.5465, 3.2143},
        {7.6372, 53.7500, 9.5465, 3.2143},
        {7.6372, 57.6786, 9.5465, 3.2143},
        {7.6372, 61.6071, 9.5465, 3.2143},
        {7.6372, 65.5357, 9.5465, 3.2143},
        {7.6372, 69.4643, 9.5465, 3.2143},
        {7.6372, 73.3929, 9.5465, 3.2143},
        {7.6372, 77.3214, 9.5465, 3.2143},
        {7.6372, 81.2500, 9.5465, 3.2143},
        {7.6372, 85.1786, 9.5465, 3.2143},
        {7.6372, 89.1071, 9.5465, 3.2143},
        {20.0477, 6.6071, 9.5465, 3.2143},
        {20.0477, 10.5357, 9.5465, 3.2143},
        {20.0477, 14.4643, 9.5465, 3.2143},
        {20.0477, 18.3929, 9.5465, 3.2143},
        {20.0477, 22.3214, 9.5465, 3.2143},
        {20.0477, 26.2500, 9.5465, 3.2143},
        {20.0477, 30.1786, 9.5465, 3.2143},
        {20.0477, 34.1071, 9.5465, 3.2143},
        {20.0477, 38.0357, 9.5465, 3.2143},
        {20.0477, 41.9643, 9.5465, 3.2143},
        {20.0477, 45.8929, 9.5465, 3.2143},
        {20.0477, 49.8214, 9.5465, 3.2143},
        {20.0477, 53.7500, 9.5465, 3.2143},
        {20.0477, 57.6786, 9.5465, 3.2143},
        {20.0477, 61.6071, 9.5465, 3.2143},
        {20.0477, 65.5357, 9.5465, 3.2143},
        {20.0477, 69.4643, 9.5465, 3.2143},
        {20.0477, 73.3929, 9.5465, 3.2143},
        {20.0477, 77.3214, 9.5465, 3.2143},
        {20.0477, 81.2500, 9.5465, 3.2143},
        {20.0477, 85.1786, 9.5465, 3.2143},
        {20.0477, 89.1071, 9.5465, 3.2143},
        {37.4702, 6.6071, 9.5465, 3.2143},
        {37.4702, 10.5357, 9.5465, 3.2143},
        {37.4702, 14.4643, 9.5465, 3.2143},
        {37.4702, 18.3929, 9.5465, 3.2143},
        {37.4702, 22.3214, 9.5465, 3.2143},
        {37.4702, 26.2500, 9.5465, 3.2143},
        {37.4702, 30.1786, 9.5465, 3.2143},
        {37.4702, 34.1071, 9.5465, 3.2143},
        {37.4702, 38.0357, 9.5465, 3.2143},
        {37.4702, 41.9643, 9.5465, 3.2143},
        {37.4702, 45.8929, 9.5465, 3.2143},
        {37.4702, 49.8214, 9.5465, 3.2143},
        {37.4702, 53.7500, 9.5465, 3.2143},
        {37.4702, 57.6786, 9.5465, 3.2143},
        {37.4702, 61.6071, 9.5465, 3.2143},
        {37.4702, 65.5357, 9.5465, 3.2143},
        {37.4702, 69.4643, 9.5465, 3.2143},
        {37.4702, 73.3929, 9.5465, 3.2143},
        {37.4702, 77.3214, 9.5465, 3.2143},
        {37.4702, 81.2500, 9.5465, 3.2143},
        {37.4702, 85.1786, 9.5465, 3.2143},
        {37.4702, 89.1071, 9.5465, 3.2143},
        {49.8807, 6.6071, 9.5465, 3.2143},
        {49.8807, 10.5357, 9.5465, 3.2143},
        {49.8807, 14.4643, 9.5465, 3.2143},
        {49.8807, 18.3929, 9.5465, 3.2143},
        {49.8807, 22.3214, 9.5465, 3.2143},
        {49.8807, 26.2500, 9.5465, 3.2143},
        {49.8807, 30.1786, 9.5465, 3.2143},
        {49.8807, 34.1071, 9.5465, 3.2143},
        {49.8807, 38.0357, 9.5465, 3.2143},
        {49.8807, 41.9643, 9.5465, 3.2143},
        {49.8807, 45.8929, 9.5465, 3.2143},
        {49.8807, 49.8214, 9.5465, 3.2143},
        {49.8807, 53.7500, 9.5465, 3.2143},
        {49.8807, 57.6786, 9.5465, 3.2143},
        {49.8807, 61.6071, 9.5465, 3.2143},
        {49.8807, 65.5357, 9.5465, 3.2143},
        {49.8807, 69.4643, 9.5465, 3.2143},
        {49.8807, 73.3929, 9.5465, 3.2143},
        {49.8807, 77.3214, 9.5465, 3.2143},
        {49.8807, 81.2500, 9.5465, 3.2143},
        {49.8807, 85.1786, 9.5465, 3.2143},
        {49.8807, 89.1071, 9.5465, 3.2143},
        {69.2124, 20.8929, 9.5465, 3.2143},
        {69.2124, 24.8214, 9.5465, 3.2143},
        {69.2124, 28.7500, 9.5465, 3.2143},
        {69.2124, 32.6786, 9.5465, 3.2143},
        {69.2124, 36.6071, 9.5465, 3.2143},
        {69.2124, 40.5357, 9.5465, 3.2143},
        {79.7136, 20.8929, 9.5465, 3.2143},
        {79.7136, 24.8214, 9.5465, 3.2143},
        {79.7136, 28.7500, 9.5465, 3.2143},
        {79.7136, 32.6786, 9.5465, 3.2143},
        {79.7136, 36.6071, 9.5465, 3.2143},
        {79.7136, 40.5357, 9.5465, 3.2143},
        {69.2124, 48.9286, 9.5465, 3.2143},
        {69.2124, 52.8571, 9.5465, 3.2143},
        {69.2124, 56.7857, 9.5465, 3.2143},
        {69.2124, 60.7143, 9.5465, 3.2143},
        {69.2124, 64.6429, 9.5465, 3.2143},
        {69.2124, 68.5714, 9.5465, 3.2143},
        {79.7136, 48.9286, 9.5465, 3.2143},
        {79.7136, 52.8571, 9.5465, 3.2143},
        {79.7136, 56.7857, 9.5465, 3.2143},
        {79.7136, 60.7143, 9.5465, 3.2143},
        {79.7136, 64.6429, 9.5465, 3.2143},
        {79.7136, 68.5714, 9.5465, 3.2143},
        {69.2124, 76.9643, 9.5465, 3.2143},
        {69.2124, 80.8929, 9.5465, 3.2143},
        {69.2124, 84.8214, 9.5465, 3.2143},
        {69.2124, 88.7500, 9.5465, 3.2143},
        {79.7136, 76.9643, 9.5465, 3.2143},
        {79.7136, 80.8929, 9.5465, 3.2143},
        {79.7136, 84.8214, 9.5465, 3.2143},
        {79.7136, 88.7500, 9.5465, 3.2143},
    };

    // ---- Himal-Motorcycle: 160 slots (4 double-rows x 20 cols x 2 lanes) ----
    static final double[][] POS_HIMAL_MOTO = {
        // row 0 lane A
        {6.6667,10.2222,4.3333,7.2222},{11.0000,10.2222,4.3333,7.2222},{15.3333,10.2222,4.3333,7.2222},{19.6667,10.2222,4.3333,7.2222},{24.0000,10.2222,4.3333,7.2222},
        {28.3333,10.2222,4.3333,7.2222},{32.6667,10.2222,4.3333,7.2222},{37.0000,10.2222,4.3333,7.2222},{41.3333,10.2222,4.3333,7.2222},{45.6667,10.2222,4.3333,7.2222},
        {50.0000,10.2222,4.3333,7.2222},{54.3333,10.2222,4.3333,7.2222},{58.6667,10.2222,4.3333,7.2222},{63.0000,10.2222,4.3333,7.2222},{67.3333,10.2222,4.3333,7.2222},
        {71.6667,10.2222,4.3333,7.2222},{76.0000,10.2222,4.3333,7.2222},{80.3333,10.2222,4.3333,7.2222},{84.6667,10.2222,4.3333,7.2222},{89.0000,10.2222,4.3333,7.2222},
        // row 0 lane B
        {6.6667,17.4444,4.3333,7.2222},{11.0000,17.4444,4.3333,7.2222},{15.3333,17.4444,4.3333,7.2222},{19.6667,17.4444,4.3333,7.2222},{24.0000,17.4444,4.3333,7.2222},
        {28.3333,17.4444,4.3333,7.2222},{32.6667,17.4444,4.3333,7.2222},{37.0000,17.4444,4.3333,7.2222},{41.3333,17.4444,4.3333,7.2222},{45.6667,17.4444,4.3333,7.2222},
        {50.0000,17.4444,4.3333,7.2222},{54.3333,17.4444,4.3333,7.2222},{58.6667,17.4444,4.3333,7.2222},{63.0000,17.4444,4.3333,7.2222},{67.3333,17.4444,4.3333,7.2222},
        {71.6667,17.4444,4.3333,7.2222},{76.0000,17.4444,4.3333,7.2222},{80.3333,17.4444,4.3333,7.2222},{84.6667,17.4444,4.3333,7.2222},{89.0000,17.4444,4.3333,7.2222},
        // row 1 lane A
        {6.6667,31.7778,4.3333,7.2222},{11.0000,31.7778,4.3333,7.2222},{15.3333,31.7778,4.3333,7.2222},{19.6667,31.7778,4.3333,7.2222},{24.0000,31.7778,4.3333,7.2222},
        {28.3333,31.7778,4.3333,7.2222},{32.6667,31.7778,4.3333,7.2222},{37.0000,31.7778,4.3333,7.2222},{41.3333,31.7778,4.3333,7.2222},{45.6667,31.7778,4.3333,7.2222},
        {50.0000,31.7778,4.3333,7.2222},{54.3333,31.7778,4.3333,7.2222},{58.6667,31.7778,4.3333,7.2222},{63.0000,31.7778,4.3333,7.2222},{67.3333,31.7778,4.3333,7.2222},
        {71.6667,31.7778,4.3333,7.2222},{76.0000,31.7778,4.3333,7.2222},{80.3333,31.7778,4.3333,7.2222},{84.6667,31.7778,4.3333,7.2222},{89.0000,31.7778,4.3333,7.2222},
        // row 1 lane B
        {6.6667,39.0000,4.3333,7.2222},{11.0000,39.0000,4.3333,7.2222},{15.3333,39.0000,4.3333,7.2222},{19.6667,39.0000,4.3333,7.2222},{24.0000,39.0000,4.3333,7.2222},
        {28.3333,39.0000,4.3333,7.2222},{32.6667,39.0000,4.3333,7.2222},{37.0000,39.0000,4.3333,7.2222},{41.3333,39.0000,4.3333,7.2222},{45.6667,39.0000,4.3333,7.2222},
        {50.0000,39.0000,4.3333,7.2222},{54.3333,39.0000,4.3333,7.2222},{58.6667,39.0000,4.3333,7.2222},{63.0000,39.0000,4.3333,7.2222},{67.3333,39.0000,4.3333,7.2222},
        {71.6667,39.0000,4.3333,7.2222},{76.0000,39.0000,4.3333,7.2222},{80.3333,39.0000,4.3333,7.2222},{84.6667,39.0000,4.3333,7.2222},{89.0000,39.0000,4.3333,7.2222},
        // row 2 lane A
        {6.6667,53.3333,4.3333,7.2222},{11.0000,53.3333,4.3333,7.2222},{15.3333,53.3333,4.3333,7.2222},{19.6667,53.3333,4.3333,7.2222},{24.0000,53.3333,4.3333,7.2222},
        {28.3333,53.3333,4.3333,7.2222},{32.6667,53.3333,4.3333,7.2222},{37.0000,53.3333,4.3333,7.2222},{41.3333,53.3333,4.3333,7.2222},{45.6667,53.3333,4.3333,7.2222},
        {50.0000,53.3333,4.3333,7.2222},{54.3333,53.3333,4.3333,7.2222},{58.6667,53.3333,4.3333,7.2222},{63.0000,53.3333,4.3333,7.2222},{67.3333,53.3333,4.3333,7.2222},
        {71.6667,53.3333,4.3333,7.2222},{76.0000,53.3333,4.3333,7.2222},{80.3333,53.3333,4.3333,7.2222},{84.6667,53.3333,4.3333,7.2222},{89.0000,53.3333,4.3333,7.2222},
        // row 2 lane B
        {6.6667,60.5556,4.3333,7.2222},{11.0000,60.5556,4.3333,7.2222},{15.3333,60.5556,4.3333,7.2222},{19.6667,60.5556,4.3333,7.2222},{24.0000,60.5556,4.3333,7.2222},
        {28.3333,60.5556,4.3333,7.2222},{32.6667,60.5556,4.3333,7.2222},{37.0000,60.5556,4.3333,7.2222},{41.3333,60.5556,4.3333,7.2222},{45.6667,60.5556,4.3333,7.2222},
        {50.0000,60.5556,4.3333,7.2222},{54.3333,60.5556,4.3333,7.2222},{58.6667,60.5556,4.3333,7.2222},{63.0000,60.5556,4.3333,7.2222},{67.3333,60.5556,4.3333,7.2222},
        {71.6667,60.5556,4.3333,7.2222},{76.0000,60.5556,4.3333,7.2222},{80.3333,60.5556,4.3333,7.2222},{84.6667,60.5556,4.3333,7.2222},{89.0000,60.5556,4.3333,7.2222},
        // row 3 lane A
        {6.6667,74.8889,4.3333,7.2222},{11.0000,74.8889,4.3333,7.2222},{15.3333,74.8889,4.3333,7.2222},{19.6667,74.8889,4.3333,7.2222},{24.0000,74.8889,4.3333,7.2222},
        {28.3333,74.8889,4.3333,7.2222},{32.6667,74.8889,4.3333,7.2222},{37.0000,74.8889,4.3333,7.2222},{41.3333,74.8889,4.3333,7.2222},{45.6667,74.8889,4.3333,7.2222},
        {50.0000,74.8889,4.3333,7.2222},{54.3333,74.8889,4.3333,7.2222},{58.6667,74.8889,4.3333,7.2222},{63.0000,74.8889,4.3333,7.2222},{67.3333,74.8889,4.3333,7.2222},
        {71.6667,74.8889,4.3333,7.2222},{76.0000,74.8889,4.3333,7.2222},{80.3333,74.8889,4.3333,7.2222},{84.6667,74.8889,4.3333,7.2222},{89.0000,74.8889,4.3333,7.2222},
        // row 3 lane B
        {6.6667,82.1111,4.3333,7.2222},{11.0000,82.1111,4.3333,7.2222},{15.3333,82.1111,4.3333,7.2222},{19.6667,82.1111,4.3333,7.2222},{24.0000,82.1111,4.3333,7.2222},
        {28.3333,82.1111,4.3333,7.2222},{32.6667,82.1111,4.3333,7.2222},{37.0000,82.1111,4.3333,7.2222},{41.3333,82.1111,4.3333,7.2222},{45.6667,82.1111,4.3333,7.2222},
        {50.0000,82.1111,4.3333,7.2222},{54.3333,82.1111,4.3333,7.2222},{58.6667,82.1111,4.3333,7.2222},{63.0000,82.1111,4.3333,7.2222},{67.3333,82.1111,4.3333,7.2222},
        {71.6667,82.1111,4.3333,7.2222},{76.0000,82.1111,4.3333,7.2222},{80.3333,82.1111,4.3333,7.2222},{84.6667,82.1111,4.3333,7.2222},{89.0000,82.1111,4.3333,7.2222},
    };

    // ---- Kumari-Motorcycle: 158 slots (3 pairs x20x2 + single x20 + bottom x18) ----
    static final double[][] POS_KUMARI_MOTO = {
        // pair 1 lane A (20) left=10.9184%
        {10.9184,5.0,5.102,3.5},{10.9184,9.0,5.102,3.5},{10.9184,13.0,5.102,3.5},{10.9184,17.0,5.102,3.5},{10.9184,21.0,5.102,3.5},
        {10.9184,25.0,5.102,3.5},{10.9184,29.0,5.102,3.5},{10.9184,33.0,5.102,3.5},{10.9184,37.0,5.102,3.5},{10.9184,41.0,5.102,3.5},
        {10.9184,45.0,5.102,3.5},{10.9184,49.0,5.102,3.5},{10.9184,53.0,5.102,3.5},{10.9184,57.0,5.102,3.5},{10.9184,61.0,5.102,3.5},
        {10.9184,65.0,5.102,3.5},{10.9184,69.0,5.102,3.5},{10.9184,73.0,5.102,3.5},{10.9184,77.0,5.102,3.5},{10.9184,81.0,5.102,3.5},
        // pair 1 lane B (20) left=17.2449%
        {17.2449,5.0,5.102,3.5},{17.2449,9.0,5.102,3.5},{17.2449,13.0,5.102,3.5},{17.2449,17.0,5.102,3.5},{17.2449,21.0,5.102,3.5},
        {17.2449,25.0,5.102,3.5},{17.2449,29.0,5.102,3.5},{17.2449,33.0,5.102,3.5},{17.2449,37.0,5.102,3.5},{17.2449,41.0,5.102,3.5},
        {17.2449,45.0,5.102,3.5},{17.2449,49.0,5.102,3.5},{17.2449,53.0,5.102,3.5},{17.2449,57.0,5.102,3.5},{17.2449,61.0,5.102,3.5},
        {17.2449,65.0,5.102,3.5},{17.2449,69.0,5.102,3.5},{17.2449,73.0,5.102,3.5},{17.2449,77.0,5.102,3.5},{17.2449,81.0,5.102,3.5},
        // pair 2 lane A (20) left=30.5102%
        {30.5102,5.0,5.102,3.5},{30.5102,9.0,5.102,3.5},{30.5102,13.0,5.102,3.5},{30.5102,17.0,5.102,3.5},{30.5102,21.0,5.102,3.5},
        {30.5102,25.0,5.102,3.5},{30.5102,29.0,5.102,3.5},{30.5102,33.0,5.102,3.5},{30.5102,37.0,5.102,3.5},{30.5102,41.0,5.102,3.5},
        {30.5102,45.0,5.102,3.5},{30.5102,49.0,5.102,3.5},{30.5102,53.0,5.102,3.5},{30.5102,57.0,5.102,3.5},{30.5102,61.0,5.102,3.5},
        {30.5102,65.0,5.102,3.5},{30.5102,69.0,5.102,3.5},{30.5102,73.0,5.102,3.5},{30.5102,77.0,5.102,3.5},{30.5102,81.0,5.102,3.5},
        // pair 2 lane B (20) left=36.8367%
        {36.8367,5.0,5.102,3.5},{36.8367,9.0,5.102,3.5},{36.8367,13.0,5.102,3.5},{36.8367,17.0,5.102,3.5},{36.8367,21.0,5.102,3.5},
        {36.8367,25.0,5.102,3.5},{36.8367,29.0,5.102,3.5},{36.8367,33.0,5.102,3.5},{36.8367,37.0,5.102,3.5},{36.8367,41.0,5.102,3.5},
        {36.8367,45.0,5.102,3.5},{36.8367,49.0,5.102,3.5},{36.8367,53.0,5.102,3.5},{36.8367,57.0,5.102,3.5},{36.8367,61.0,5.102,3.5},
        {36.8367,65.0,5.102,3.5},{36.8367,69.0,5.102,3.5},{36.8367,73.0,5.102,3.5},{36.8367,77.0,5.102,3.5},{36.8367,81.0,5.102,3.5},
        // pair 3 lane A (20) left=50.102%
        {50.102,5.0,5.102,3.5},{50.102,9.0,5.102,3.5},{50.102,13.0,5.102,3.5},{50.102,17.0,5.102,3.5},{50.102,21.0,5.102,3.5},
        {50.102,25.0,5.102,3.5},{50.102,29.0,5.102,3.5},{50.102,33.0,5.102,3.5},{50.102,37.0,5.102,3.5},{50.102,41.0,5.102,3.5},
        {50.102,45.0,5.102,3.5},{50.102,49.0,5.102,3.5},{50.102,53.0,5.102,3.5},{50.102,57.0,5.102,3.5},{50.102,61.0,5.102,3.5},
        {50.102,65.0,5.102,3.5},{50.102,69.0,5.102,3.5},{50.102,73.0,5.102,3.5},{50.102,77.0,5.102,3.5},{50.102,81.0,5.102,3.5},
        // pair 3 lane B (20) left=56.4286%
        {56.4286,5.0,5.102,3.5},{56.4286,9.0,5.102,3.5},{56.4286,13.0,5.102,3.5},{56.4286,17.0,5.102,3.5},{56.4286,21.0,5.102,3.5},
        {56.4286,25.0,5.102,3.5},{56.4286,29.0,5.102,3.5},{56.4286,33.0,5.102,3.5},{56.4286,37.0,5.102,3.5},{56.4286,41.0,5.102,3.5},
        {56.4286,45.0,5.102,3.5},{56.4286,49.0,5.102,3.5},{56.4286,53.0,5.102,3.5},{56.4286,57.0,5.102,3.5},{56.4286,61.0,5.102,3.5},
        {56.4286,65.0,5.102,3.5},{56.4286,69.0,5.102,3.5},{56.4286,73.0,5.102,3.5},{56.4286,77.0,5.102,3.5},{56.4286,81.0,5.102,3.5},
        // single column (20) left=83.9796%
        {83.9796,5.0,5.102,3.5},{83.9796,9.0,5.102,3.5},{83.9796,13.0,5.102,3.5},{83.9796,17.0,5.102,3.5},{83.9796,21.0,5.102,3.5},
        {83.9796,25.0,5.102,3.5},{83.9796,29.0,5.102,3.5},{83.9796,33.0,5.102,3.5},{83.9796,37.0,5.102,3.5},{83.9796,41.0,5.102,3.5},
        {83.9796,45.0,5.102,3.5},{83.9796,49.0,5.102,3.5},{83.9796,53.0,5.102,3.5},{83.9796,57.0,5.102,3.5},{83.9796,61.0,5.102,3.5},
        {83.9796,65.0,5.102,3.5},{83.9796,69.0,5.102,3.5},{83.9796,73.0,5.102,3.5},{83.9796,77.0,5.102,3.5},{83.9796,81.0,5.102,3.5},
        // bottom row (18) top=90.75%
        {10.9184,90.75,3.8776,6.5},{15.3061,90.75,3.8776,6.5},{19.6939,90.75,3.8776,6.5},{24.0816,90.75,3.8776,6.5},{28.4694,90.75,3.8776,6.5},
        {32.8571,90.75,3.8776,6.5},{37.2449,90.75,3.8776,6.5},{41.6327,90.75,3.8776,6.5},{46.0204,90.75,3.8776,6.5},{50.4082,90.75,3.8776,6.5},
        {54.7959,90.75,3.8776,6.5},{59.1837,90.75,3.8776,6.5},{63.5714,90.75,3.8776,6.5},{67.9592,90.75,3.8776,6.5},{72.3469,90.75,3.8776,6.5},
        {76.7347,90.75,3.8776,6.5},{81.1224,90.75,3.8776,6.5},{85.5102,90.75,3.8776,6.5},
    };

    // ---- Kumari-Car: 41 slots (6+4+1+2+4+12+12) on 980x520 canvas ----
    static final double[][] POS_KUMARI_CAR = {
        // Group 1: 6 slots top row (y=52, h=52, w=85, step=93)
        {5.6122,10.0000,8.6735,10.0000},{15.1020,10.0000,8.6735,10.0000},{24.5918,10.0000,8.6735,10.0000},
        {34.0816,10.0000,8.6735,10.0000},{43.5714,10.0000,8.6735,10.0000},{53.0612,10.0000,8.6735,10.0000},
        // Group 2: 4 slots second row (y=120, h=52, w=85)
        {5.6122,23.0769,8.6735,10.0000},{15.1020,23.0769,8.6735,10.0000},
        {24.5918,23.0769,8.6735,10.0000},{34.0816,23.0769,8.6735,10.0000},
        // Group 3: 1 slot beside tree, second row (x=520, y=120, w=85, h=52)
        {53.0612,23.0769,8.6735,10.0000},
        // Group 4: 2 slots right column (x=880, w=70, h=52)
        {89.7959,10.0000,7.1429,10.0000},{89.7959,23.0769,7.1429,10.0000},
        // Group 5: 4 slots middle (x=200..479, y=225, h=52, w=85, step=93)
        {20.4082,43.2692,8.6735,10.0000},{29.8980,43.2692,8.6735,10.0000},
        {39.3878,43.2692,8.6735,10.0000},{48.8776,43.2692,8.6735,10.0000},
        // Group 6: 12 slots bottom row A (y=352, h=50, w=65, step=73)
        {3.2653,67.6923,6.6327,9.6154},{10.7143,67.6923,6.6327,9.6154},{18.1633,67.6923,6.6327,9.6154},
        {25.6122,67.6923,6.6327,9.6154},{33.0612,67.6923,6.6327,9.6154},{40.5102,67.6923,6.6327,9.6154},
        {47.9592,67.6923,6.6327,9.6154},{55.4082,67.6923,6.6327,9.6154},{62.8571,67.6923,6.6327,9.6154},
        {70.3061,67.6923,6.6327,9.6154},{77.7551,67.6923,6.6327,9.6154},{85.2041,67.6923,6.6327,9.6154},
        // Group 7: 12 slots bottom row B (y=426, h=50, w=65, step=73)
        {3.2653,81.9231,6.6327,9.6154},{10.7143,81.9231,6.6327,9.6154},{18.1633,81.9231,6.6327,9.6154},
        {25.6122,81.9231,6.6327,9.6154},{33.0612,81.9231,6.6327,9.6154},{40.5102,81.9231,6.6327,9.6154},
        {47.9592,81.9231,6.6327,9.6154},{55.4082,81.9231,6.6327,9.6154},{62.8571,81.9231,6.6327,9.6154},
        {70.3061,81.9231,6.6327,9.6154},{77.7551,81.9231,6.6327,9.6154},{85.2041,81.9231,6.6327,9.6154},
    };
%>
<!DOCTYPE html>
<html>
<head>
    <title>Slot Map - ParkEZz</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slotGrid.css">
    <style>
        .slot-box { width: 36px !important; height: 36px !important; font-size: 10px !important; border-width: 1.5px !important; border-radius: 4px !important; }
        .slot-grid { gap: 5px !important; }
        .slot-lane { gap: 4px !important; }
        .slot-grid-lanes { gap: 12px !important; }
        .main-content { padding: 16px 20px !important; }
    </style>
</head>
<body>
<div class="dashboard-wrapper">

    <%-- sidebar --%>
    <div class="sidebar">
        <div class="sidebar-brand">
            <span class="brand-title">ParkEZz</span>
            <span class="brand-sub">College Parking</span>
        </div>
        <p class="sidebar-section">Main</p>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/slotMap" class="sidebar-link active">Slot Map</a>
        <p class="sidebar-section">Manage</p>
        <a href="${pageContext.request.contextPath}/admin/users" class="sidebar-link">Users</a>
        <a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-link">Generate Reports</a>
        <div class="sidebar-footer">
            <div class="avatar-circle">AD</div>
            <div>
                <p class="admin-name">Admin</p>
                <p class="admin-role">Administrator</p>
            </div>
        </div>
    </div>

    <%-- main content --%>
    <div class="main-content">
        <div class="page-header">
            <div>
                <h2>Slot Map</h2>
                <p class="sub">Visual Slot editor</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="btn-logout">Logout</a>
        </div>

        <%-- lot + type filter --%>
        <form method="get" action="${pageContext.request.contextPath}/admin/slotMap" class="filter-bar">
            <select name="lotId" onchange="this.form.submit()">
                <%
                    List<Lot> lots = (List<Lot>) request.getAttribute("lots");
                    String selectedLotId = request.getParameter("lotId");
                    if (selectedLotId == null) selectedLotId = (String) request.getAttribute("selectedLotId");
                    if (lots != null) {
                        for (Lot lot : lots) {
                            String selected = (selectedLotId != null &&
                                selectedLotId.equals(String.valueOf(lot.getLotId()))) ? "selected" : "";
                %>
                    <option value="<%= lot.getLotId() %>" <%= selected %>>
                        <%= lot.getLotName() %>
                    </option>
                <%
                        }
                    }
                %>
            </select>
        </form>

        <%-- slot grid --%>
        <%
            List<Slot> slots = (List<Slot>) request.getAttribute("slots");

            // resolve selected lot name
            String selLotName = "";
            String selLotId = request.getParameter("lotId");
            if (selLotId == null) selLotId = (String) request.getAttribute("selectedLotId");
            if (lots != null && selLotId != null) {
                for (Lot l : lots) {
                    if (selLotId.equals(String.valueOf(l.getLotId()))) {
                        selLotName = l.getLotName();
                        break;
                    }
                }
            }

            if ("Skill - Motorcycle".equals(selLotName) && slots != null) {
                double[][] slotPos = POS_SKILL_MOTO;
        %>
        <div class="schematic-wrap" style="position:relative;display:inline-block;max-width:100%;margin:16px 0;">
            <img src="${pageContext.request.contextPath}/logo/schematic_skill_moto.svg" style="display:block;width:100%;max-width:980px;height:auto;border-radius:8px;" alt="Skill Motorcycle Lot"/>
            <%
                for (int si = 0; si < slots.size() && si < slotPos.length; si++) {
                    Slot slot = slots.get(si);
                    String label = slot.getSlotLabel();
                    String color = "Occupied".equals(label) ? "#dc2626" : "Reserved".equals(label) ? "#ca8a04" : "#16a34a";
                    double[] p = slotPos[si];
            %>
            <a href="${pageContext.request.contextPath}/admin/slotDetail?slotNo=<%= slot.getSlotNo() %>"
               style="position:absolute;left:<%= String.format("%.4f", p[0]) %>%;top:<%= String.format("%.4f", p[1]) %>%;width:<%= String.format("%.4f", p[2]) %>%;height:<%= String.format("%.4f", p[3]) %>%;display:flex;align-items:center;justify-content:center;font-size:10px;font-weight:600;font-family:sans-serif;border:1.5px solid <%= color %>;color:<%= color %>;background:transparent;border-radius:3px;text-decoration:none;box-sizing:border-box;cursor:pointer;">
                <%= slot.getSlotNo() %>
            </a>
            <% } %>
        </div>
        <%
            } else if ("Skill - Car".equals(selLotName) && slots != null) {
                double[][] slotPos = POS_SKILL_CAR;
        %>
        <div class="schematic-wrap" style="position:relative;display:inline-block;max-width:100%;margin:16px 0;">
            <img src="${pageContext.request.contextPath}/logo/schematic_skill_car.svg" style="display:block;width:100%;max-width:838px;height:auto;border-radius:8px;" alt="Skill Car Lot"/>
            <%
                for (int si = 0; si < slots.size() && si < slotPos.length; si++) {
                    Slot slot = slots.get(si);
                    String label = slot.getSlotLabel();
                    String color = "Occupied".equals(label) ? "#dc2626" : "Reserved".equals(label) ? "#ca8a04" : "#16a34a";
                    double[] p = slotPos[si];
            %>
            <a href="${pageContext.request.contextPath}/admin/slotDetail?slotNo=<%= slot.getSlotNo() %>"
               style="position:absolute;left:<%= String.format("%.4f", p[0]) %>%;top:<%= String.format("%.4f", p[1]) %>%;width:<%= String.format("%.4f", p[2]) %>%;height:<%= String.format("%.4f", p[3]) %>%;display:flex;align-items:center;justify-content:center;font-size:10px;font-weight:600;font-family:sans-serif;border:1.5px solid <%= color %>;color:<%= color %>;background:transparent;border-radius:3px;text-decoration:none;box-sizing:border-box;cursor:pointer;">
                <%= slot.getSlotNo() %>
            </a>
            <% } %>
        </div>
        <%
            } else if ("Himal - Motorcycle".equals(selLotName) && slots != null) {
                double[][] slotPos = POS_HIMAL_MOTO;
        %>
        <div class="schematic-wrap" style="position:relative;display:inline-block;max-width:100%;margin:16px 0;">
            <img src="${pageContext.request.contextPath}/logo/schematic_himal_moto.svg" style="display:block;width:100%;max-width:1200px;height:auto;border-radius:8px;" alt="Himal Motorcycle Lot"/>
            <%
                for (int si = 0; si < slots.size() && si < slotPos.length; si++) {
                    Slot slot = slots.get(si);
                    String label = slot.getSlotLabel();
                    String color = "Occupied".equals(label) ? "#dc2626" : "Reserved".equals(label) ? "#ca8a04" : "#16a34a";
                    double[] p = slotPos[si];
            %>
            <a href="${pageContext.request.contextPath}/admin/slotDetail?slotNo=<%= slot.getSlotNo() %>"
               style="position:absolute;left:<%= String.format("%.4f", p[0]) %>%;top:<%= String.format("%.4f", p[1]) %>%;width:<%= String.format("%.4f", p[2]) %>%;height:<%= String.format("%.4f", p[3]) %>%;display:flex;align-items:center;justify-content:center;font-size:10px;font-weight:600;font-family:sans-serif;border:1.5px solid <%= color %>;color:<%= color %>;background:transparent;border-radius:3px;text-decoration:none;box-sizing:border-box;cursor:pointer;">
                <%= slot.getSlotNo() %>
            </a>
            <% } %>
        </div>
        <%
            } else if ("Kumari - Motorcycle".equals(selLotName) && slots != null) {
                double[][] slotPos = POS_KUMARI_MOTO;
        %>
        <div class="schematic-wrap" style="position:relative;display:inline-block;max-width:100%;margin:16px 0;">
            <img src="${pageContext.request.contextPath}/logo/schematic_kumari_moto.svg" style="display:block;width:100%;max-width:980px;height:auto;border-radius:8px;" alt="Kumari Motorcycle Lot"/>
            <%
                for (int si = 0; si < slots.size() && si < slotPos.length; si++) {
                    Slot slot = slots.get(si);
                    String label = slot.getSlotLabel();
                    String color = "Occupied".equals(label) ? "#dc2626" : "Reserved".equals(label) ? "#ca8a04" : "#16a34a";
                    double[] p = slotPos[si];
            %>
            <a href="${pageContext.request.contextPath}/admin/slotDetail?slotNo=<%= slot.getSlotNo() %>"
               style="position:absolute;left:<%= String.format("%.4f", p[0]) %>%;top:<%= String.format("%.4f", p[1]) %>%;width:<%= String.format("%.4f", p[2]) %>%;height:<%= String.format("%.4f", p[3]) %>%;display:flex;align-items:center;justify-content:center;font-size:10px;font-weight:600;font-family:sans-serif;border:1.5px solid <%= color %>;color:<%= color %>;background:transparent;border-radius:3px;text-decoration:none;box-sizing:border-box;cursor:pointer;">
                <%= slot.getSlotNo() %>
            </a>
            <% } %>
        </div>
        <%
            } else if ("Kumari - Car".equals(selLotName) && slots != null) {
                double[][] slotPos = POS_KUMARI_CAR;
        %>
        <div class="schematic-wrap" style="position:relative;display:inline-block;max-width:100%;margin:16px 0;">
            <img src="${pageContext.request.contextPath}/logo/schematic_kumari_car.svg" style="display:block;width:100%;max-width:980px;height:auto;border-radius:8px;" alt="Kumari Car Lot"/>
            <%
                for (int si = 0; si < slots.size() && si < slotPos.length; si++) {
                    Slot slot = slots.get(si);
                    String label = slot.getSlotLabel();
                    String color = "Occupied".equals(label) ? "#dc2626" : "Reserved".equals(label) ? "#ca8a04" : "#16a34a";
                    double[] p = slotPos[si];
            %>
            <a href="${pageContext.request.contextPath}/admin/slotDetail?slotNo=<%= slot.getSlotNo() %>"
               style="position:absolute;left:<%= String.format("%.4f", p[0]) %>%;top:<%= String.format("%.4f", p[1]) %>%;width:<%= String.format("%.4f", p[2]) %>%;height:<%= String.format("%.4f", p[3]) %>%;display:flex;align-items:center;justify-content:center;font-size:10px;font-weight:600;font-family:sans-serif;border:1.5px solid <%= color %>;color:<%= color %>;background:transparent;border-radius:3px;text-decoration:none;box-sizing:border-box;cursor:pointer;">
                <%= slot.getSlotNo() %>
            </a>
            <% } %>
        </div>
        <%
            } else {
            // lane groups for other lots
            int[][] laneGroups = null;

            if (slots != null && laneGroups != null) {
        %>
        <div class="slot-grid-lanes">
            <%
                int slotIdx = 0;
                for (int[] group : laneGroups) {
                    boolean isPair = group.length == 2;
            %>
            <div class="slot-lane-group <%= isPair ? "slot-lane-pair" : "" %>">
                <%
                    for (int laneSize : group) {
                %>
                <div class="slot-lane">
                    <%
                        for (int i = 0; i < laneSize && slotIdx < slots.size(); i++, slotIdx++) {
                            Slot slot = slots.get(slotIdx);
                            String label = slot.getSlotLabel();
                            String cssClass = "slot-box ";
                            if ("Occupied".equals(label)) cssClass += "slot-occupied";
                            else if ("Reserved".equals(label)) cssClass += "slot-reserved";
                            else cssClass += "slot-available";
                    %>
                    <a href="${pageContext.request.contextPath}/admin/slotDetail?slotNo=<%= slot.getSlotNo() %>"
                       class="<%= cssClass %>">
                        <%= slot.getSlotNo() %>
                    </a>
                    <%
                        }
                    %>
                </div>
                <%
                    }
                %>
            </div>
            <%
                }
            %>
        </div>
        <%
            } else if (slots != null) {
        %>
        <div class="slot-grid">
            <%
                for (Slot slot : slots) {
                    String label = slot.getSlotLabel();
                    String cssClass = "slot-box ";
                    if ("Occupied".equals(label)) cssClass += "slot-occupied";
                    else if ("Reserved".equals(label)) cssClass += "slot-reserved";
                    else cssClass += "slot-available";
            %>
                <a href="${pageContext.request.contextPath}/admin/slotDetail?slotNo=<%= slot.getSlotNo() %>"
                   class="<%= cssClass %>">
                    <%= slot.getSlotNo() %>
                </a>
            <%
                }
            %>
        </div>
        <%
            }
            } // end else (non-schematic lots)
        %>

        <%-- legend --%>
        <div class="legend">
            <span class="legend-item"><span class="dot dot-green"></span> Free</span>
            <span class="legend-item"><span class="dot dot-red"></span> Occupied</span>
            <span class="legend-item"><span class="dot dot-yellow"></span> Reserved</span>
        </div>

        <%-- popup for free slot --%>
        <%
            Slot selectedSlot = (Slot) request.getAttribute("selectedSlot");
            if (selectedSlot != null && "Available".equals(selectedSlot.getSlotLabel())) {
        %>
        <div class="popup-overlay">
            <div class="popup-box">
                <p class="popup-slot-label">Slot <%= selectedSlot.getSlotNo() %></p>
                <form method="post" action="${pageContext.request.contextPath}/slot/enter">
                    <input type="hidden" name="slotNo" value="<%= selectedSlot.getSlotNo() %>"/>
                    <input type="hidden" name="lotId" value="<%= selectedSlot.getLotId() %>"/>
                    <label>Enter Vehicle Number</label>
                    <input type="text" name="vehicleNo" placeholder="Vehicle No" required/>
                    <input type="hidden" name="userId" value="1"/>
                    <div class="popup-actions">
                        <button type="submit" class="btn-occupy">Occupy</button>
                        <button type="submit" formaction="${pageContext.request.contextPath}/slot/reserve"
                                class="btn-reserve">Reserve</button>
                    </div>
                </form>
                <a href="${pageContext.request.contextPath}/admin/slotMap" class="btn-close">✕</a>
            </div>
        </div>
        <%  } %>

        <%-- popup for occupied/reserved slot --%>
        <%
            Record activeRecord = (Record) request.getAttribute("activeRecord");
            if (selectedSlot != null && !"Available".equals(selectedSlot.getSlotLabel())) {
                String dispVehicleNo = activeRecord != null ? activeRecord.getVehicleNo() : "—";
                String dispName      = activeRecord != null && activeRecord.getFullName() != null ? activeRecord.getFullName() : "Unregistered";
                String dispPhone     = activeRecord != null && activeRecord.getPhone() != null ? activeRecord.getPhone() : "—";
                String formVehicleNo = activeRecord != null ? activeRecord.getVehicleNo() : "";
                int    formUserId    = activeRecord != null ? activeRecord.getUserId() : 0;
        %>
        <div class="popup-overlay">
            <div class="popup-box">
                <p class="popup-slot-label">Slot <%= selectedSlot.getSlotNo() %></p>
                <p class="popup-label">Vehicle No</p>
                <p class="popup-value"><%= dispVehicleNo %></p>
                <p class="popup-label">Name</p>
                <p class="popup-value"><%= dispName %></p>
                <p class="popup-label">Phone</p>
                <p class="popup-value"><%= dispPhone %></p>
                <form method="post" action="${pageContext.request.contextPath}/slot/exit">
                    <input type="hidden" name="slotNo" value="<%= selectedSlot.getSlotNo() %>"/>
                    <input type="hidden" name="lotId" value="<%= selectedSlot.getLotId() %>"/>
                    <input type="hidden" name="vehicleNo" value="<%= formVehicleNo %>"/>
                    <input type="hidden" name="userId" value="<%= formUserId %>"/>
                    <button type="submit" class="btn-clear">Clear</button>
                </form>
                <a href="${pageContext.request.contextPath}/admin/slotMap" class="btn-close">✕</a>
            </div>
        </div>
        <% } %>

    </div>
</div>
</body>
</html>
