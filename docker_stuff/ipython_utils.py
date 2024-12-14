
class C:
    @classmethod
    def cc_dates(cls, cc):
        from collections import Counter
        return dict(sorted(Counter(str(d.date()) for d in cc.values_list('source_created', flat=True)).items()))

    @classmethod
    def cc_dates_by_channel(cls, cc):
        from collections import Counter
        return dict(sorted(Counter((c, str(d.date())) for c, d in cc.values_list('channel', 'source_created')).items()))

    @classmethod
    def cc_months(cls, cc):
        from collections import Counter
        return dict(sorted(Counter(
            (d.year, d.month)
            for d in cc.values_list( 'source_created', flat=True)
            ).items()))

    @classmethod
    def cc_months_by_channel(cls, cc):
        from collections import Counter
        return dict(sorted(Counter(
            (c, d.year, d.month)
            for c, d in cc.values_list('channel', 'source_created')
            ).items()))

    
    @classmethod
    def c(cls, i):
        return Conversation.objects.filter(id=i).first()
