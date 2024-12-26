import csv
from django.conf import settings
from django.core.management.base import BaseCommand
from app.models import Location



class Command(BaseCommand):
    help = 'Load data from Location file'

    def handle(self, *args, **kwargs):
        data_file = settings.BASE_DIR / 'data' / 'Location.csv'
        keys = ('Station Name', 'New Georeferenced Column')  # the CSV columns we will gather data from.
        
        records = []
        with open(data_file, 'r') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                # records.append({k: row[k] for k in keys})
                records.append({k: row.get(k, None) for k in keys})

        # extract the latitude and longitude from the Point object
        for record in records:
            longitude, latitude = record['New Georeferenced Column'].split("(")[-1].split(")")[0].split()
            record['longitude'] = float(longitude)
            record['latitude'] = float(latitude)

            # add the data to the database
            Location.objects.get_or_create(
                name = record['Station Name'],
                latitude = record['latitude'],
                longitude = record['longitude']
            )


# import csv
# from django.conf import settings
# from django.core.management.base import BaseCommand
# from app.models import Location


# class Command(BaseCommand):
#     help = 'Load data from Location file'

#     def handle(self, *args, **kwargs):
#         data_file = settings.BASE_DIR / 'data' / 'Location.csv'
#         keys = ('Station Name', 'New Georeferenced Column')  # the CSV columns we will gather data from.
        
#         records = []
#         with open(data_file, 'r') as csvfile:
#             reader = csv.DictReader(csvfile)
#             for row in reader:
#                 records.append({k: row[k] for k in keys})

#         # extract the latitude and longitude from the Point object
#         for record in records:
#             longitude, latitude = record['New Georeferenced Column'].split("(")[-1].split(")")[0].split()
#             record['longitude'] = float(longitude)
#             record['latitude'] = float(latitude)

#             # add the data to the database
#             Location.objects.get_or_create(
#                 name=record['Station Name'],
#                 longitude=record['longitude'],
#                 latitude=record['latitude'],
                
#             )

# import csv
# from django.conf import settings
# from django.core.management.base import BaseCommand
# from app.models import Location

# class Command(BaseCommand):
#     help = 'Load data from Location file'

#     def handle(self, *args, **kwargs):
#         data_file = settings.BASE_DIR / 'data' / 'Location.csv'
#         keys = ('Station Name', 'New Georeferenced Column')  # the CSV columns we will gather data from.
        
#         records = []
#         with open(data_file, 'r') as csvfile:
#             reader = csv.DictReader(csvfile)
#             for row in reader:
#                 # Check if 'Station Name' key exists in the row
#                 if 'Station Name' in row:
#                     # Extract latitude and longitude from 'New Georeferenced Column'
#                     georeferenced_column = row['New Georeferenced Column']
#                     longitude, latitude = georeferenced_column.split("(")[-1].split(")")[0].split()
#                     record = {
#                         'name': row['Station Name'],
#                         'longitude': float(longitude),
#                         'latitude': float(latitude),
#                     }
#                     records.append(record)
#                 else:
#                     self.stdout.write(self.style.WARNING(f'Skipping record without "Station Name": {row}'))

#         # Add the data to the database
#         Location.objects.bulk_create([Location(**record) for record in records])
        




     



