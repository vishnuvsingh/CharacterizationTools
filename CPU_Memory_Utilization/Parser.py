import csv
import re
import statistics as stats

def getAllInstances(file):
    pattern = re.compile("CONTAINER")
    
    CTDict = {}
    
    with open(file, "r") as StatsFile:
        reader = csv.reader(StatsFile)
        for row in reader:
            if(pattern.search(row[0])):
                continue

            if(row[1] not in CTDict):
                CTDict[row[1]] = ([], [])
      
            CTDict[row[1]][0].append(float(row[2].strip("%")))
            CTDict[row[1]][1].append(float(row[5].strip("%")))
            
    return CTDict

CTDict = getAllInstances("ContainerStats.csv")

print("Container", "CPU-Mean", "CPU-Median", "CPU-Stddev","Memory-Mean", "Memory-Median", "Memory-Stddev")
for Container in CTDict:
    print(Container, stats.mean(CTDict[Container][0]), stats.median(CTDict[Container][0]), stats.stdev(CTDict[Container][0]), stats.mean(CTDict[Container][1]), stats.median(CTDict[Container][1]), stats.stdev(CTDict[Container][1]))    