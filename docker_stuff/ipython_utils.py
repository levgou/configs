from more_itertools import flatten, chunked, collapse
from organization.models import *
from brain.models import *
from pprint import pp
from djangocommon import conversation_utils
from collections import Counter, defaultdict
from django.utils import timezone
from django.db.models import TextChoices, Q, F
from ipython_utils import *


class C:
    @classmethod
    def cc_dates(cls, cc):
        return dict(
            sorted(
                Counter(
                    str(d.date()) for d in cc.values_list("source_created", flat=True)
                ).items()
            )
        )

    @classmethod
    def cc_dates_by_channel(cls, cc):
        return dict(
            sorted(
                Counter(
                    (c, str(d.date()))
                    for c, d in cc.values_list("channel", "source_created")
                ).items()
            )
        )

    @classmethod
    def cc_dates_by_channel_installation(cls, cc):
        return dict(
            sorted(
                Counter(
                    (c, str(d.date()))
                    for c, d in cc.values_list(
                        "installation__slug", "channel", "source_created"
                    )
                ).items()
            )
        )

    @classmethod
    def cc_months(cls, cc):
        from collections import Counter

        return dict(
            sorted(
                Counter(
                    (d.year, d.month)
                    for d in cc.values_list("source_created", flat=True)
                ).items()
            )
        )

    @classmethod
    def cc_months_by_channel(cls, cc):
        from collections import Counter

        return dict(
            sorted(
                Counter(
                    (c, d.year, d.month)
                    for c, d in cc.values_list("channel", "source_created")
                ).items()
            )
        )

    @classmethod
    def c(cls, i):
        return Conversation.objects.filter(id=i).first()

    @classmethod
    def d(cls, d1: str):
        return Conversation.objects.filter(source_created__gt=d1)

    @classmethod
    def dd(cls, d1: str, d2: str):
        return Conversation.objects.filter(source_created__gt=d1, source_created__lt=d2)

    @classmethod
    def dc(cls, d1: str, client_slug: str):
        if d1 == "1w":
            raise Exception("not impl")

        return cls.d(d1).filter(client__slug=client_slug)

    @classmethod
    def ddc(cls, d1: str, d2: str, client_slug: str):
        return cls.dd(d1, d2).filter(client__slug=client_slug)

    @classmethod
    def get_cd(cls, conversation):
        from djangocommon.conversation_utils import (
            annotate_conversations_query_set_with_in_messages_and_out_messages,
        )

        c = annotate_conversations_query_set_with_in_messages_and_out_messages(
            Conversation.objects.filter(id=conversation.id),
            True,
            False,
            False,
            True,
            False,
        ).get()
        print(
            f"Conversation: \n{c.contact_driver_intent=} \n{c.loris_contact_driver_intent=} \n{c.llm_contact_driver_intent=}"
        )
        print("---" * 10)
        for im in c.in_messages:
            if ia := getattr(im, "in_analysis", None):
                if any(
                    [
                        ia.contact_driver_intent,
                        ia.loris_contact_driver_intent,
                        ia.llm_contact_driver_intent,
                    ]
                ):
                    print(
                        f"ia {im.id=} {ia.id=}:\n"
                        f"{ia.contact_driver_intent=}\n{ia.loris_contact_driver_intent=}\n{ia.llm_contact_driver_intent=}"
                    )

    @classmethod
    def rem_cd(cls, conversation):
        from djangocommon.conversation_utils import (
            annotate_conversations_query_set_with_in_messages_and_out_messages,
        )

        c = annotate_conversations_query_set_with_in_messages_and_out_messages(
            Conversation.objects.filter(id=conversation.id),
            True,
            False,
            False,
            True,
            False,
        ).get()
        if c.loris_contact_driver_intent:
            c.loris_contact_driver_intent = None
            print("removed loris cd")
        if c.llm_contact_driver_intent:
            c.llm_contact_driver_intent = None
            print("removed llm cd")
        if c.contact_driver_intent:
            c.contact_driver_intent = None
            print("removed cd")
        for im in c.in_messages:
            if ia := getattr(im, "in_analysis", None):
                if ia.loris_contact_driver_intent:
                    ia.loris_contact_driver_intent = None
                    print("ia removed loris cd", ia)
                if ia.llm_contact_driver_intent:
                    ia.llm_contact_driver_intent = None
                    print("ia removed llm cd", ia)
                if ia.contact_driver_intent:
                    ia.contact_driver_intent = None
                    print("ia removed cd", ia)
                ia.save()
        c.save()

    @classmethod
    def get_gist(cls, conversation):
        return {
            "reeson_for_contact": conversation.conversationsummary.reason_for_contact,
            "agent_actions": conversation.conversationsummary.agent_actions,
            "agent_follow_up": conversation.conversationsummary.agent_follow_up,
            "customer_satisfaction": conversation.conversationsummary.customer_satisfaction,
            "is_resolved": (
                True
                if conversation.resolution_value == 1
                else False
                if conversation.resolution_value == 2
                else None
            ),
            "resolution_reasoning": conversation.conversationresolution.resolution_reasoning,
        }
