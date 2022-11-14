from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model

class Command(BaseCommand):
    help = 'Populate Database'

    def seeder_database(self):
        User = get_user_model()
        User.objects.create_superuser(email='admin@example.com', password="p3s8Word_123")
        User.objects.create_superuser(email='staff@example.com', password="p3s8Word_123")
        User.objects.create_user(email='user@example.com', password='example', **{"is_active": True, "is_staff": True})

    def handle(self, *args, **options):
        self.seeder_database()
