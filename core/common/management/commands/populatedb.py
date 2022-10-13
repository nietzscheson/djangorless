from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model

class Command(BaseCommand):
    help = 'Populate Database'

    def seeder_database(self):
        User = get_user_model()
        User.objects.create_superuser(username='admin@example.com', password="example")
        User.objects.create_user(username='user@example.com', password='example', **{"is_active": True, "is_staff": True})

    def handle(self, *args, **options):
        self.seeder_database()
